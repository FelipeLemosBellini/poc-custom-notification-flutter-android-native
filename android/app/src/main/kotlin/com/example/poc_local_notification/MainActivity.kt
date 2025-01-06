package com.example.poc_local_notification

import io.flutter.embedding.android.FlutterActivity

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.poc_local_notification"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            println("call.method: " + call.method)

            if (call.method == "showProgressBarNotification") {
                val progress = call.argument<Int>("progress") ?: 0
                println("progress: "+progress)
                showCustomNotification(progress)
                result.success(null)
            } else {
                println("Não achou o método")
                result.notImplemented()
            }
        }

        println("open CHANNEL")
    }

    private fun showCustomNotification(progress: Int) {
        val channelId = "progress_channel"
        val notificationId = 1

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            println("Build.VERSION.SDK_INT >= Build.VERSION_CODES.O")
            val channel = NotificationChannel(
                channelId,
                "Notificação com Barra de Progresso",
                NotificationManager.IMPORTANCE_LOW
            )
            notificationManager.createNotificationChannel(channel)
        }

        println(Build.VERSION.SDK_INT)

        val notificationLayout = RemoteViews(packageName, R.layout.progress_ride)
//        notificationLayout.setTextViewText(R.id.title, "Andamento da corrida")
        notificationLayout.setProgressBar(R.id.progress_bar, 100, progress, false)
        notificationLayout.setTextViewText(R.id.progress_text, "Motorista a caminho $progress% progresso")

        val notification = NotificationCompat.Builder(this, channelId)
            .setCustomContentView(notificationLayout)
//            .setCustomBigContentView(notificationLayoutExpanded)
            .setStyle(NotificationCompat.DecoratedCustomViewStyle())
            .setSmallIcon(R.drawable.ic_car)
            .setOnlyAlertOnce(true) // Notifica apenas a primeira vez
            .build()

        notificationManager.notify(notificationId, notification)
    }
}


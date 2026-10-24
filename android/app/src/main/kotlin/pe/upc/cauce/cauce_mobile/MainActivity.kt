package pe.upc.cauce.cauce_mobile

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createDefaultNotificationChannel()
    }

    // Canal que el servidor nombra en cada push. Crearlo otra vez no pisa
    // los ajustes que el paciente ya le cambió.
    private fun createDefaultNotificationChannel() {
        val channel = NotificationChannel(
            DEFAULT_CHANNEL_ID,
            getString(R.string.app_name),
            NotificationManager.IMPORTANCE_HIGH,
        )
        getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
    }

    private companion object {
        const val DEFAULT_CHANNEL_ID = "cauce_default"
    }
}

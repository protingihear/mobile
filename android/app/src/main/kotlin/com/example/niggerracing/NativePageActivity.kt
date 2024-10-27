package com.example.mediapipe

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.example.mediapipe.databinding.ActivityNativePageBinding

class NativePageActivity : AppCompatActivity() {
    private lateinit var binding: ActivityNativePageBinding
    private val viewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityNativePageBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navHostFragment = supportFragmentManager.findFragmentById(R.id.fragment_container) as NavHostFragment
        val navController = navHostFragment.navController
        binding.navigation.setupWithNavController(navController)
        binding.navigation.setOnNavigationItemReselectedListener {
            // ignore reselection behavior
        }
    }

    override fun onBackPressed() {
        finish()
    }
}

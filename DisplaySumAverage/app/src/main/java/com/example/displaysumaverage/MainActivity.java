package com.example.displaysumaverage;

import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private EditText num1;
    private EditText num2;
    private EditText num3;
    private Button button;
    private TextView sumavg;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        num1 = findViewById(R.id.num1);
        num2 = findViewById(R.id.num2);
        num3 = findViewById(R.id.num3);
        button = findViewById(R.id.button);
        sumavg = findViewById(R.id.sumavg);

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                calculatesumavg();
            }
        }

    }
        private void calculatesumavg() {
            // Get input values
            String subject1 = num1.getText().toString();
            String subject2 = num2.getText().toString();
            String subject3 = num3.getText().toString();

            // Check if input fields are not empty
            if (!subject1.isEmpty() && !subject2.isEmpty() && !subject3.isEmpty()) {
                // Parse input values to integers
                int marks1 = Integer.parseInt(subject1);
                int marks2 = Integer.parseInt(subject2);
                int marks3 = Integer.parseInt(subject3);

                // Calculate sum and average
                int sum = marks1 + marks2 + marks3;
                double average = sum / 3.0;

                // Display results
                String resultText = "Sum: " + sum + "\nAverage: " + average;
                sumavg.setText(resultText);
            } else {
                // Display error message if any field is empty
                sumavg.setText("Please enter marks for all subjects.");
            }
        }
}
package com.sportpj.sportpj.Service;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class RateLimitingService {
    // Stores the last 3 timestamps an email requested an OTP
    private final Map<String, java.util.Queue<LocalDateTime>> otpRequests = new ConcurrentHashMap<>();

    private static final int MAX_REQUESTS_PER_HOUR = 3;

    public boolean canRequestOtp(String email) {
        otpRequests.putIfAbsent(email, new java.util.LinkedList<>());
        java.util.Queue<LocalDateTime> requests = otpRequests.get(email);

        // Remove requests older than 1 hour
        LocalDateTime oneHourAgo = LocalDateTime.now().minusHours(1);
        while (!requests.isEmpty() && requests.peek().isBefore(oneHourAgo)) {
            requests.poll();
        }

        return requests.size() < MAX_REQUESTS_PER_HOUR;
    }

    public void recordOtpRequest(String email) {
        otpRequests.putIfAbsent(email, new java.util.LinkedList<>());
        otpRequests.get(email).add(LocalDateTime.now());
    }
}

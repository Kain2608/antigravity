package com.sportpj.sportpj.Model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "verification_codes")
@Getter
@Setter
public class VerificationCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false, length = 10)
    private String otpCode;

    // e.g. "REGISTER", "RESET_PASSWORD"
    @Column(nullable = false)
    private String type; 

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime expiresAt;
    
    @Column(nullable = false)
    private int attempts = 0;
    
    public void incrementAttempts() {
        this.attempts++;
    }
    
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(this.expiresAt);
    }
}

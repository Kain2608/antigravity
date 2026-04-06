package com.sportpj.sportpj.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportpj.sportpj.Model.VerificationCode;

@Repository
public interface VerificationCodeRepository extends JpaRepository<VerificationCode, Long> {
    VerificationCode findTopByEmailAndTypeOrderByCreatedAtDesc(String email, String type);
}

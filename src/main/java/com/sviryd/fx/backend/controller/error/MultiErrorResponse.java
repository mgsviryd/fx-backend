package com.sviryd.fx.backend.controller.error;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class MultiErrorResponse {
    private int status;
    private String message;
    private LocalDateTime ldt = LocalDateTime.now();
    private List<ErrorDetail> errors = new ArrayList<>();

    public void addError(String field, String message, String code) {
        errors.add(new ErrorDetail(field, message, code));
    }
}

package com.acme.scheduler.appointments.api;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.Valid;

import java.time.Instant;

public record CreateAppointmentRequest(
  @NotBlank String tenantId,
  @NotBlank String clinicId,
  @NotBlank String providerId,
  @NotBlank String patientId,
  @NotNull Instant startTime,
  @NotNull Instant endTime,
  @NotBlank String timeZone,
  @Valid Contact contact
) {
  public record Contact(String email, String phone) {}
}

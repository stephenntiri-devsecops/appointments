package com.acme.scheduler.appointments.api;

import com.acme.scheduler.appointments.service.AppointmentService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController {

  private final AppointmentService service;

  public AppointmentController(AppointmentService service) {
    this.service = service;
  }

  @PostMapping
  public ResponseEntity<AppointmentResponse> create(
      @RequestHeader("Idempotency-Key") String idempotencyKey,
      @Valid @RequestBody CreateAppointmentRequest req
  ) {
    // Minimal demo idempotency:
    // Production: persist (idempotencyKey, requestHash, response) per tenant.
    UUID id = service.createAppointment(req);
    return ResponseEntity.ok(new AppointmentResponse(id, "BOOKED"));
  }
}

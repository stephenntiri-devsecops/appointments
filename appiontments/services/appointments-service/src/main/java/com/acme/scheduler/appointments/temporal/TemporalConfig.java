package com.acme.scheduler.appointments.temporal;

import io.temporal.client.WorkflowClient;
import io.temporal.serviceclient.WorkflowServiceStubs;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TemporalConfig {

  @Bean
  public WorkflowClient workflowClient(
      @Value("${app.temporal.target}") String target,
      @Value("${app.temporal.namespace}") String namespace
  ) {
    WorkflowServiceStubs service = WorkflowServiceStubs.newServiceStubs(
      io.temporal.serviceclient.WorkflowServiceStubsOptions.newBuilder()
        .setTarget(target)
        .build()
    );
    return WorkflowClient.newInstance(service,
      io.temporal.client.WorkflowClientOptions.newBuilder().setNamespace(namespace).build());
  }
}

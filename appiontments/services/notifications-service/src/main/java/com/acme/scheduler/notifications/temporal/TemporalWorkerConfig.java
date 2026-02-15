package com.acme.scheduler.notifications.temporal;

import io.temporal.client.WorkflowClient;
import io.temporal.serviceclient.WorkflowServiceStubs;
import io.temporal.worker.WorkerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TemporalWorkerConfig {

  @Bean(destroyMethod = "shutdown")
  public WorkerFactory workerFactory(
      @Value("${app.temporal.target}") String target,
      @Value("${app.temporal.namespace}") String namespace,
      @Value("${app.temporal.taskQueue}") String taskQueue,
      NotificationActivitiesImpl activities
  ) {
    WorkflowServiceStubs service = WorkflowServiceStubs.newServiceStubs(
      io.temporal.serviceclient.WorkflowServiceStubsOptions.newBuilder().setTarget(target).build()
    );
    WorkflowClient client = WorkflowClient.newInstance(service,
      io.temporal.client.WorkflowClientOptions.newBuilder().setNamespace(namespace).build());

    WorkerFactory factory = WorkerFactory.newInstance(client);
    var worker = factory.newWorker(taskQueue);
    worker.registerWorkflowImplementationTypes(AppointmentNotificationWorkflowImpl.class);
    worker.registerActivitiesImplementations(activities);

    factory.start();
    return factory;
  }
}

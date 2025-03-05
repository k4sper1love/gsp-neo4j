# Global Student Portal - Neo4j
## Task
The task was to calculate stability metrics for **Global Student Portal** by transferring the dependency graph to **Neo4j**.

The following metrics should have been taken into account:
1. **Fan-in** - shows how many components depend on the current component.
2. **Fan-out** - shows how many components the current component depends on.
3. **Instability** - shows the instability of the component, where 0 is stable and 1 is unstable.

## Solution
### Neo4j
To create and run **Neo4j**, **Docker Compose** was used.

You can run it using the following command
```sh
docker-compose up --build
```

To log in, use `neo4j:password`

### Migrations
A file with migrations (`migrations.cypher`) has been created, which includes all our components and the dependencies between them.

To apply migrations, use the following command
```sh
cat migrations.cypher | docker exec -i neo4j cypher-shell -u neo4j -p password
```

### Getting results
To calculate the stability metrics for each component of our system, a query was written, which is saved in the file `stability_metrics.cypher`

The following formula was used to calculate the instability:
```yml
  CASE
       WHEN (FanIn + FanOut) = 0 THEN 1
       ELSE toFloat(FanOut) / (FanIn + FanOut)
       END AS I
```

To get the results, use the following command
```sh
cat stability_metrics.cypher | docker exec -i neo4j cypher-shell -u neo4j -p password | tee stability_metrics.md
```

You can find the results in the file `stability_metrics.md `

## Results
Here you can see the results of calculations of stability metrics.

| Component                      | Fan-in | Fan-out | I      |
|--------------------------------|--------|---------|--------|
| Netscaler                      | 0      | 1       | 1.0    |
| Monitoring & Analytics         | 0      | 1       | 1.0    |
| Global VIP                     | 1      | 5       | 0.8333 |
| Institution VIP                | 1      | 4       | 0.8    |
| OAuth                          | 1      | 3       | 0.75   |
| Course Registration            | 1      | 3       | 0.75   |
| Monolith                       | 1      | 3       | 0.75   |
| Institution Management         | 1      | 3       | 0.75   |
| UI                             | 1      | 2       | 0.6667 |
| Web UI                         | 1      | 2       | 0.6667 |
| Mobile UI                      | 1      | 2       | 0.6667 |
| Balancer                       | 2      | 4       | 0.6667 |
| Institution DB 1               | 1      | 1       | 0.5    |
| Institution DB N               | 1      | 1       | 0.5    |
| Observer                       | 2      | 1       | 0.3333 |
| Global Pool                    | 2      | 1       | 0.3333 |
| Institution Pool               | 2      | 1       | 0.3333 |
| Queue (Kafka)                  | 6      | 0       | 0.0    |
| Caching                        | 4      | 0       | 0.0    |
| CDN                            | 2      | 0       | 0.0    |
| Global Auth DB                 | 1      | 0       | 0.0    |
| Global Auth DB Sync Replica    | 1      | 0       | 0.0    |
| Global Meta DB                 | 1      | 0       | 0.0    |
| Global Meta DB Sync Replica    | 1      | 0       | 0.0    |
| Global Meta DB Async Replica   | 1      | 0       | 0.0    |
| Institution DB 1 Sync Replica  | 1      | 0       | 0.0    |
| Institution DB N Sync Replica  | 1      | 0       | 0.0    |


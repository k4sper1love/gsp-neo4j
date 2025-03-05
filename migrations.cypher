// Components
CREATE (netscaler:Component {name: 'Netscaler'})
CREATE (ui:Component {name: 'UI'})
CREATE (web:Component {name: 'Web UI'})
CREATE (mobile:Component {name: 'Mobile UI'})
CREATE (balancer:Component {name: 'Balancer'})
CREATE (oauth:Component {name: 'OAuth'})
CREATE (course_registration:Component {name: 'Course Registration'})
CREATE (monolith:Component {name: 'Monolith'})
CREATE (institution_management:Component {name: 'Institution Management'})
CREATE (queue:Component {name: 'Queue (Kafka)'})
CREATE (monitoring:Component {name: 'Monitoring & Analytics'})
CREATE (observer:Component {name: 'Observer'})
CREATE (caching:Component {name: 'Caching'})
CREATE (cdn:Component {name: 'CDN'})
CREATE (global_pool:Component {name: 'Global Pool'})
CREATE (global_vip:Component {name: 'Global VIP'})
CREATE (global_auth_db:Component {name: 'Global Auth DB'})
CREATE (global_auth_db_sync_replica:Component {name: 'Global Auth DB Sync Replica'})
CREATE (global_meta_db:Component {name: 'Global Meta DB'})
CREATE (global_meta_db_sync_replica:Component {name: 'Global Meta DB Sync Replica'})
CREATE (global_meta_db_async_replica:Component {name: 'Global Meta DB Async Replica'})
CREATE (institution_pool:Component {name: 'Institution Pool'})
CREATE (institution_vip:Component {name: 'Institution VIP'})
CREATE (institution_db_1:Component {name: 'Institution DB 1'})
CREATE (institution_db_1_sync_replica:Component {name: 'Institution DB 1 Sync Replica'})
CREATE (institution_db_n:Component {name: 'Institution DB N'})
CREATE (institution_db_n_sync_replica:Component {name: 'Institution DB N Sync Replica'})

WITH *

// Dependencies
MATCH (netscaler:Component {name: 'Netscaler'}), (ui:Component {name: 'UI'})
CREATE (netscaler)-[:DEPENDS_ON]->(ui);

MATCH (ui:Component {name: 'UI'}), (web:Component {name: 'Web UI'})
CREATE (ui)-[:DEPENDS_ON]->(web);

MATCH (ui:Component {name: 'UI'}), (mobile:Component {name: 'Mobile UI'})
CREATE (ui)-[:DEPENDS_ON]->(mobile);

MATCH (cdn:Component {name: 'CDN'}), (web:Component {name: 'Web UI'})
CREATE (web)-[:DEPENDS_ON]->(cdn);

MATCH (cdn:Component {name: 'CDN'}), (mobile:Component {name: 'Mobile UI'})
CREATE (mobile)-[:DEPENDS_ON]->(cdn);

MATCH (web:Component {name: 'Web UI'}), (balancer:Component {name: 'Balancer'})
CREATE (web)-[:DEPENDS_ON]->(balancer);

MATCH (mobile:Component {name: 'Mobile UI'}), (balancer:Component {name: 'Balancer'})
CREATE (mobile)-[:DEPENDS_ON]->(balancer);

MATCH (balancer:Component {name: 'Balancer'}), (oauth:Component {name: 'OAuth'})
CREATE (balancer)-[:DEPENDS_ON]->(oauth);

MATCH (balancer:Component {name: 'Balancer'}), (course_registration:Component {name: 'Course Registration'})
CREATE (balancer)-[:DEPENDS_ON]->(course_registration);

MATCH (balancer:Component {name: 'Balancer'}), (monolith:Component {name: 'Monolith'})
CREATE (balancer)-[:DEPENDS_ON]->(monolith);

MATCH (balancer:Component {name: 'Balancer'}), (institution_management:Component {name: 'Institution Management'})
CREATE (balancer)-[:DEPENDS_ON]->(institution_management);

MATCH (institution_db_1:Component {name: 'Institution DB 1'}), (observer:Component {name: 'Observer'})
CREATE (institution_db_1)-[:DEPENDS_ON]->(observer);

MATCH (institution_db_n:Component {name: 'Institution DB N'}), (observer:Component {name: 'Observer'})
CREATE (institution_db_n)-[:DEPENDS_ON]->(observer);

MATCH (observer:Component {name: 'Observer'}), (queue:Component {name: 'Queue (Kafka)'})
CREATE (observer)-[:DEPENDS_ON]->(queue);

MATCH (queue:Component {name: 'Queue (Kafka)'}), (course_registration:Component {name: 'Course Registration'})
CREATE (course_registration)-[:DEPENDS_ON]->(queue);

MATCH (queue:Component {name: 'Queue (Kafka)'}), (institution_management:Component {name: 'Institution Management'})
CREATE (institution_management)-[:DEPENDS_ON]->(queue);

MATCH (queue:Component {name: 'Queue (Kafka)'}), (oauth:Component {name: 'OAuth'})
CREATE (oauth)-[:DEPENDS_ON]->(queue);

MATCH (queue:Component {name: 'Queue (Kafka)'}), (monolith:Component {name: 'Monolith'})
CREATE (monolith)-[:DEPENDS_ON]->(queue);

MATCH (queue:Component {name: 'Queue (Kafka)'}), (monitoring:Component {name: 'Monitoring & Analytics'})
CREATE (monitoring)-[:DEPENDS_ON]->(queue);

MATCH (caching:Component {name: 'Caching'}), (course_registration:Component {name: 'Course Registration'})
CREATE (course_registration)-[:DEPENDS_ON]->(caching);

MATCH (caching:Component {name: 'Caching'}), (institution_management:Component {name: 'Institution Management'})
CREATE (institution_management)-[:DEPENDS_ON]->(caching);

MATCH (caching:Component {name: 'Caching'}), (oauth:Component {name: 'OAuth'})
CREATE (oauth)-[:DEPENDS_ON]->(caching);

MATCH (caching:Component {name: 'Caching'}), (monolith:Component {name: 'Monolith'})
CREATE (monolith)-[:DEPENDS_ON]->(caching);

MATCH (oauth:Component {name: 'OAuth'}),(global_pool:Component {name: 'Global Pool'})
CREATE (oauth)-[:DEPENDS_ON]->(global_pool);

MATCH (institution_management:Component {name: 'Institution Management'}),(global_pool:Component {name: 'Global Pool'})
CREATE (institution_management)-[:DEPENDS_ON]->(global_pool);

MATCH (course_registration:Component {name: 'Course Registration'}), (institution_pool:Component {name: 'Institution Pool'})
CREATE (course_registration)-[:DEPENDS_ON]->(institution_pool);

MATCH (monolith:Component {name: 'Monolith'}), (institution_pool:Component {name: 'Institution Pool'})
CREATE (monolith)-[:DEPENDS_ON]->(institution_pool);

MATCH (global_pool:Component {name: 'Global Pool'}), (global_vip:Component {name: 'Global VIP'})
CREATE (global_pool)-[:DEPENDS_ON]->(global_vip);

MATCH (global_vip:Component {name: 'Global VIP'}), (global_auth_db:Component {name: 'Global Auth DB'})
CREATE (global_vip)-[:DEPENDS_ON]->(global_auth_db);

MATCH (global_vip:Component {name: 'Global VIP'}), (global_auth_db_sync_replica:Component {name: 'Global Auth DB Sync Replica'})
CREATE (global_vip)-[:DEPENDS_ON]->(global_auth_db_sync_replica);

MATCH (global_vip:Component {name: 'Global VIP'}), (global_meta_db:Component {name: 'Global Meta DB'})
CREATE (global_vip)-[:DEPENDS_ON]->(global_meta_db);

MATCH (global_vip:Component {name: 'Global VIP'}), (global_meta_db_sync_replica:Component {name: 'Global Meta DB Sync Replica'})
CREATE (global_vip)-[:DEPENDS_ON]->(global_meta_db_sync_replica);

MATCH (global_vip:Component {name: 'Global VIP'}), (global_meta_db_async_replica:Component {name: 'Global Meta DB Async Replica'})
CREATE (global_vip)-[:DEPENDS_ON]->(global_meta_db_async_replica);

MATCH (institution_pool:Component {name: 'Institution Pool'}), (institution_vip:Component {name: 'Institution VIP'})
CREATE (institution_pool)-[:DEPENDS_ON]->(institution_vip);

MATCH (institution_vip:Component {name: 'Institution VIP'}), (institution_db_1:Component {name: 'Institution DB 1'})
CREATE (institution_vip)-[:DEPENDS_ON]->(institution_db_1);

MATCH (institution_vip:Component {name: 'Institution VIP'}), (institution_db_1_sync_replica:Component {name: 'Institution DB 1 Sync Replica'})
CREATE (institution_vip)-[:DEPENDS_ON]->(institution_db_1_sync_replica);

MATCH (institution_vip:Component {name: 'Institution VIP'}), (institution_db_n:Component {name: 'Institution DB N'})
CREATE (institution_vip)-[:DEPENDS_ON]->(institution_db_n);

MATCH (institution_vip:Component {name: 'Institution VIP'}), (institution_db_n_sync_replica:Component {name: 'Institution DB N Sync Replica'})
CREATE (institution_vip)-[:DEPENDS_ON]->(institution_db_n_sync_replica);

MATCH (institution_db_1:Component {name: 'Institution DB 1'}), (global_meta_db:Component {name: 'Global Meta DB'})
CREATE (institution_db_1)-[:DEPENDS_ON]->(global_meta_db);

MATCH (institution_db_n:Component {name: 'Institution DB N'}), (global_meta_db:Component {name: 'Global Meta DB'})
CREATE (institution_db_n)-[:DEPENDS_ON]->(global_meta_db);
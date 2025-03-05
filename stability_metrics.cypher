MATCH (c:Component)
OPTIONAL MATCH (c)<-[:DEPENDS_ON]-(in)
WITH c, count(in) AS FanIn
OPTIONAL MATCH (c)-[:DEPENDS_ON]->(out)
WITH c, FanIn, count(out) AS FanOut
WITH c.name AS Component,
     FanIn,
     FanOut,
     CASE
       WHEN (FanIn + FanOut) = 0 THEN 1
       ELSE toFloat(FanOut) / (FanIn + FanOut)
       END AS I
RETURN Component, FanIn, FanOut, I
  ORDER BY I DESC;

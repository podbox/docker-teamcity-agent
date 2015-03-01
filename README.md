```
docker run --link podbox-teamcity:teamcity --name teamcity-agent-1 -t podbox/teamcity-agent
docker run --link podbox-teamcity:teamcity --name teamcity-agent-2 -t podbox/teamcity-agent
docker run --link podbox-teamcity:teamcity --name teamcity-agent-3 -t podbox/teamcity-agent
```

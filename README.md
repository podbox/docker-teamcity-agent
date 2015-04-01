```
docker run --link podbox-teamcity:teamcity --name agent-1 -t podbox/teamcity-agent
docker run --link podbox-teamcity:teamcity --name agent-2 -t podbox/teamcity-agent
docker run --link podbox-teamcity:teamcity --name agent-3 -t podbox/teamcity-agent
```

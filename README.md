`docker-compose.yml` sample:

```yaml
teamcity:
  image: podbox/teamcity
  dns: 8.8.8.8
  restart: always

teamcity-agent-1:
  image: podbox/teamcity-agent
  dns: 8.8.8.8
  restart: always
  links:
    - teamcity

teamcity-agent-2:
  image: podbox/teamcity-agent
  dns: 8.8.8.8
  restart: always
  links:
    - teamcity

teamcity-agent-3:
  image: podbox/teamcity-agent
  dns: 8.8.8.8
  restart: always
  links:
    - teamcity
```

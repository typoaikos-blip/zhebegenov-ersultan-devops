# zhebegenov-ersultan-devops

DevOps Fundamentals laboratory work: Linux → Git → GitHub → Docker → Jenkins.

| | |
|---|---|
| Student | Zhebegenov Ersultan |
| Group | IT2-2309 |
| Student ID | 37138 |
| Course | DevOps |

## Structure

```
app/app.py                              # Python app: prints student info + HTTP server on 8000
scripts/Zhebegenov_Ersultan_system.sh   # Student + system information script
config/app.conf                         # Application configuration
Zhebegenov_Ersultan_info.txt            # Student information
Dockerfile                              # Image zhebegenov-ersultan-devops
docker-compose.yml                      # Starts container zhebegenov-ersultan-container
Jenkinsfile                             # Checkout → Build → Test → Docker Build → Docker Run
```

## Run

```bash
./scripts/Zhebegenov_Ersultan_system.sh
docker build -t zhebegenov-ersultan-devops .
docker run -d -p 8000:8000 --name zhebegenov-ersultan-container zhebegenov-ersultan-devops
docker compose up -d
```

# Deploy to Render (Java WAR + Tomcat + MySQL)

## 1) Push latest code

From project root:

```powershell
git add .
git commit -m "Prepare Render deployment"
git push
```

## 2) Create Web Service on Render

1. Open Render dashboard.
2. New + -> Web Service.
3. Connect your GitHub repo.
4. Select branch `gauri`.
5. Render auto-detects `render.yaml` and `Dockerfile`.
6. Confirm service settings and create.

## 3) Set environment variables (required)

In Render -> your service -> Environment:

- `DB_URL` = `jdbc:mysql://<host>:3306/online_exam?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true`
- `DB_USER` = your db user
- `DB_PASS` = your db password

## 4) Initialize database schema

Run `database_schema.sql` against your hosted MySQL instance.

Important tables/columns required by current app:
- `results.suspiciousCount`
- `violations` table

## 5) Deploy and verify

After deploy, open:
- `/` (student login)
- `/admin/adminLogin.jsp`
- `/student/register.jsp`

## Notes

- App is deployed as `ROOT.war`, so no `/exam` prefix is needed on Render.
- Container startup script binds Tomcat to Render's runtime `PORT` automatically.
- Any new commit triggers auto-deploy when `autoDeploy` is enabled.

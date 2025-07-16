# 🚀 Comprehensive Deployment Setup Guide

This guide provides complete instructions for deploying the Fido SBA Copilot application across different environments and platforms.

## 📋 Prerequisites

Before deploying, ensure you have:

### Required Services
- ✅ **OpenAI API Key** with GPT-4 access
- ✅ **MongoDB Atlas cluster** or local MongoDB instance
- ✅ **GitHub repository** with your code
- ✅ **Domain name** (optional but recommended)

### Required Tools
- ✅ **Node.js 18+** and npm 9+
- ✅ **Docker** and Docker Compose (for containerized deployment)
- ✅ **Git** for version control

## 🏗️ Project Structure

```
fido-sba-copilot/
├── backend/                 # Node.js Express API
│   ├── index.js            # Main server file
│   ├── package.json        # Backend dependencies
│   └── .env.example        # Environment variables template
├── frontend/               # Static frontend files
│   ├── index.html         # Main HTML file
│   └── public/
│       ├── config.js      # Frontend configuration
│       ├── main.js        # Main JavaScript application
│       └── styles.css     # Application styles
├── .github/workflows/     # GitHub Actions CI/CD
│   └── deploy.yml        # Deployment workflow
├── scripts/              # Deployment utilities
│   ├── deploy-check.js   # Pre-deployment validation
│   └── setup-github.sh  # GitHub setup script
├── Dockerfile           # Single container deployment
├── Dockerfile.backend   # Backend-only container
├── Dockerfile.frontend  # Frontend-only container
├── docker-compose.yml   # Multi-container setup
├── nginx.conf          # Nginx configuration
├── mongo-init.js       # MongoDB initialization
└── deployment docs/    # Deployment documentation
```

## 🔧 Environment Setup

### 1. Backend Environment Variables

Create `backend/.env` file:

```env
# OpenAI Configuration
OPENAI_API_KEY=sk-your-openai-api-key-here

# MongoDB Configuration
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/fido?retryWrites=true&w=majority

# JWT Secret (generate a secure random string)
JWT_SECRET=your-super-secure-jwt-secret-key-here

# Environment
NODE_ENV=production

# Server Configuration
PORT=3000

# Frontend URL (for CORS)
FRONTEND_URL=https://your-frontend-domain.com
```

### 2. Frontend Configuration

Update `frontend/public/config.js`:

```javascript
const config = {
  API_BASE: window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
    ? 'http://localhost:3000'
    : 'https://your-backend-url.com', // Update this with your backend URL
  
  isDevelopment: window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1',
  
  endpoints: {
    auth: {
      signup: '/auth/signup',
      login: '/auth/login'
    },
    chat: '/chat',
    export: '/export',
    health: '/health'
  }
};
```

## 🌐 Deployment Options

### Option 1: Cloud Platforms (Recommended)

#### A. Vercel (Frontend) + Render (Backend)

**Backend on Render:**
1. Create account at [render.com](https://render.com)
2. Connect your GitHub repository
3. Create new Web Service:
   - **Name**: `fido-backend`
   - **Root Directory**: `backend`
   - **Build Command**: `npm install`
   - **Start Command**: `node index.js`
4. Add environment variables in Render dashboard
5. Deploy and copy the backend URL

**Frontend on Vercel:**
1. Create account at [vercel.com](https://vercel.com)
2. Import your GitHub repository
3. Configure deployment:
   - **Root Directory**: `frontend`
   - **Framework**: Other
4. Update `config.js` with your backend URL
5. Deploy

#### B. Railway (Full Stack)

1. Create account at [railway.app](https://railway.app)
2. Connect GitHub repository
3. Create services:
   - **Backend Service**: Root directory `backend/`
   - **Frontend Service**: Root directory `frontend/`
4. Add environment variables
5. Deploy both services

#### C. Heroku (Full Stack)

1. Install Heroku CLI
2. Create Heroku app:
   ```bash
   heroku create fido-sba-copilot
   ```
3. Set environment variables:
   ```bash
   heroku config:set OPENAI_API_KEY=your_key
   heroku config:set MONGODB_URI=your_mongodb_uri
   heroku config:set JWT_SECRET=your_secret
   ```
4. Deploy:
   ```bash
   git push heroku main
   ```

### Option 2: Docker Deployment

#### A. Single Container Deployment

```bash
# Build and run single container
docker build -t fido-sba-copilot .
docker run -p 80:80 -p 3000:3000 \
  -e OPENAI_API_KEY=your_key \
  -e MONGODB_URI=your_mongodb_uri \
  -e JWT_SECRET=your_secret \
  fido-sba-copilot
```

#### B. Multi-Container with Docker Compose

1. Create `.env` file in project root:
   ```env
   OPENAI_API_KEY=your_openai_key
   JWT_SECRET=your_jwt_secret
   ```

2. Run with Docker Compose:
   ```bash
   # Start all services
   docker-compose up -d
   
   # Or start single container version
   docker-compose --profile single-container up -d
   ```

3. Access application:
   - Frontend: http://localhost
   - Backend: http://localhost:3000
   - MongoDB: localhost:27017

#### C. Kubernetes Deployment

Create Kubernetes manifests:

```yaml
# k8s/namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: fido-sba-copilot

---
# k8s/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fido-config
  namespace: fido-sba-copilot
data:
  NODE_ENV: "production"
  PORT: "3000"

---
# k8s/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: fido-secrets
  namespace: fido-sba-copilot
type: Opaque
data:
  OPENAI_API_KEY: <base64-encoded-key>
  JWT_SECRET: <base64-encoded-secret>
  MONGODB_URI: <base64-encoded-uri>
```

### Option 3: VPS/Server Deployment

#### A. Ubuntu/Debian Server

1. **Install Dependencies:**
   ```bash
   # Update system
   sudo apt update && sudo apt upgrade -y
   
   # Install Node.js 18
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs
   
   # Install PM2 for process management
   sudo npm install -g pm2
   
   # Install Nginx
   sudo apt install nginx -y
   ```

2. **Deploy Application:**
   ```bash
   # Clone repository
   git clone https://github.com/yourusername/fido-sba-copilot.git
   cd fido-sba-copilot
   
   # Install backend dependencies
   cd backend
   npm install
   
   # Create environment file
   cp .env.example .env
   # Edit .env with your values
   
   # Start with PM2
   pm2 start index.js --name fido-backend
   pm2 startup
   pm2 save
   ```

3. **Configure Nginx:**
   ```nginx
   # /etc/nginx/sites-available/fido
   server {
       listen 80;
       server_name your-domain.com;
       
       # Frontend
       location / {
           root /path/to/fido-sba-copilot/frontend;
           index index.html;
           try_files $uri $uri/ /index.html;
       }
       
       # Backend API
       location /api/ {
           proxy_pass http://localhost:3000/;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

4. **Enable and Start Services:**
   ```bash
   sudo ln -s /etc/nginx/sites-available/fido /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## 🔍 Pre-Deployment Validation

Run the deployment check script:

```bash
npm run deploy:check
```

This will verify:
- ✅ Environment variables are set
- ✅ Required files exist
- ✅ Dependencies are installed
- ✅ Security configurations
- ✅ Database connectivity

## 🧪 Testing Deployment

### Health Check
```bash
curl https://your-backend-url.com/health
```

### API Testing
```bash
# Test signup
curl -X POST https://your-backend-url.com/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Test login
curl -X POST https://your-backend-url.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

## 🔒 Security Checklist

- [ ] ✅ Environment variables are secure
- [ ] ✅ HTTPS is enabled
- [ ] ✅ CORS is properly configured
- [ ] ✅ Rate limiting is active
- [ ] ✅ Input validation is implemented
- [ ] ✅ JWT secrets are strong
- [ ] ✅ Database connections are secure
- [ ] ✅ Security headers are set
- [ ] ✅ No sensitive data in logs
- [ ] ✅ API keys are not exposed

## 📊 Monitoring and Maintenance

### Application Monitoring
- Set up health check endpoints
- Monitor API response times
- Track error rates
- Monitor database performance

### Log Management
```bash
# PM2 logs
pm2 logs fido-backend

# Docker logs
docker logs fido-backend

# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Backup Strategy
- Regular database backups
- Code repository backups
- Configuration file backups
- SSL certificate backups

## 🔄 CI/CD Pipeline

The included GitHub Actions workflow (`/.github/workflows/deploy.yml`) provides:

- ✅ Automated testing on push
- ✅ Security vulnerability scanning
- ✅ Automatic deployment to staging/production
- ✅ Multi-platform support (Render, Railway, Vercel)

### GitHub Secrets Required:
```
OPENAI_API_KEY=your_openai_key
MONGODB_URI=your_mongodb_uri
JWT_SECRET=your_jwt_secret
RENDER_API_KEY=your_render_api_key
RENDER_SERVICE_ID=your_render_service_id
VERCEL_TOKEN=your_vercel_token
ORG_ID=your_vercel_org_id
PROJECT_ID=your_vercel_project_id
```

## 🚨 Troubleshooting

### Common Issues

1. **CORS Errors**
   - Check CORS configuration in `backend/index.js`
   - Verify frontend URL in environment variables

2. **Database Connection Issues**
   - Verify MongoDB URI format
   - Check network access settings in MongoDB Atlas
   - Ensure database user has correct permissions

3. **OpenAI API Errors**
   - Verify API key is correct and has GPT-4 access
   - Check usage limits and billing

4. **Deployment Failures**
   - Check build logs in deployment platform
   - Verify all environment variables are set
   - Check file paths and dependencies

### Getting Help

1. Check the deployment logs
2. Verify all environment variables
3. Test API endpoints manually
4. Check database connectivity
5. Review security configurations

## 🎉 Success Metrics

Your deployment is successful when:

- ✅ Health check returns 200 OK
- ✅ Frontend loads without errors
- ✅ User registration/login works
- ✅ Chat functionality is operational
- ✅ Business plan export works
- ✅ All security headers are present
- ✅ Performance is acceptable (< 3s load time)

## 📈 Scaling Considerations

### Performance Optimization
- Enable gzip compression
- Use CDN for static assets
- Implement caching strategies
- Optimize database queries
- Use connection pooling

### Horizontal Scaling
- Load balancer configuration
- Multiple backend instances
- Database read replicas
- Session management
- Stateless architecture

---

**🎯 Ready to Deploy?** Choose your preferred deployment method and follow the step-by-step instructions above. For additional help, refer to the platform-specific documentation or create an issue in the repository.
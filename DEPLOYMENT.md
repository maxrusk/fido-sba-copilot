# 🚀 Deployment Guide

This guide will help you deploy your Fido SBA Copilot application to production.

## 📋 Prerequisites

Before deploying, ensure you have:

- ✅ GitHub repository with your code
- ✅ OpenAI API key with GPT-4 access
- ✅ MongoDB Atlas cluster
- ✅ Domain name (optional but recommended)

## 🌐 Deployment Options

### Option 1: Vercel (Frontend) + Render (Backend) - Recommended

#### Frontend Deployment (Vercel)

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Deploy to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Sign up/login with GitHub
   - Click "New Project"
   - Import your repository
   - Set root directory to `frontend/`
   - Deploy!

3. **Configure Frontend**
   - Update API URLs in `frontend/public/main.js`:
   ```javascript
   const API_BASE_URL = 'https://your-backend-url.onrender.com';
   ```

#### Backend Deployment (Render)

1. **Create Render Account**
   - Go to [render.com](https://render.com)
   - Sign up with GitHub

2. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Set root directory to `backend/`

3. **Configure Environment**
   - **Name**: `fido-backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `node index.js`

4. **Add Environment Variables**
   ```
   OPENAI_API_KEY=your_openai_api_key_here
   MONGODB_URI=your_mongodb_atlas_connection_string
   JWT_SECRET=your_secure_jwt_secret_key
   NODE_ENV=production
   PORT=10000
   ```

5. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment to complete
   - Copy the provided URL (e.g., `https://fido-backend.onrender.com`)

### Option 2: Railway (Full Stack)

1. **Deploy to Railway**
   - Go to [railway.app](https://railway.app)
   - Connect your GitHub repository
   - Create new project

2. **Configure Services**
   - Create two services:
     - **Frontend Service**: Root directory `frontend/`
     - **Backend Service**: Root directory `backend/`

3. **Environment Variables**
   - Add the same environment variables as above
   - Railway will auto-detect Node.js

### Option 3: Heroku (Full Stack)

1. **Install Heroku CLI**
   ```bash
   # macOS
   brew install heroku/brew/heroku
   
   # Windows
   # Download from https://devcenter.heroku.com/articles/heroku-cli
   ```

2. **Create Heroku App**
   ```bash
   heroku login
   heroku create fido-sba-copilot
   ```

3. **Configure Environment**
   ```bash
   heroku config:set OPENAI_API_KEY=your_key
   heroku config:set MONGODB_URI=your_mongodb_uri
   heroku config:set JWT_SECRET=your_secret
   heroku config:set NODE_ENV=production
   ```

4. **Deploy**
   ```bash
   git push heroku main
   ```

## 🔧 Configuration

### CORS Settings

Update your backend CORS configuration in `backend/index.js`:

```javascript
const corsOptions = {
  origin: process.env.NODE_ENV === 'production' 
    ? ['https://your-frontend-domain.vercel.app'] // Your frontend URL
    : ['http://localhost:3000', 'http://127.0.0.1:3000'],
  credentials: true,
  optionsSuccessStatus: 200
};
```

### Environment Variables

Create a `.env` file for local development:

```env
# OpenAI Configuration
OPENAI_API_KEY=sk-your-openai-api-key

# MongoDB Atlas
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/fido?retryWrites=true&w=majority

# JWT Secret (generate a secure random string)
JWT_SECRET=your-super-secure-jwt-secret-key-here

# Environment
NODE_ENV=development
PORT=3000
```

### MongoDB Atlas Setup

1. **Create Cluster**
   - Go to [mongodb.com/atlas](https://mongodb.com/atlas)
   - Create free cluster
   - Choose cloud provider and region

2. **Database Access**
   - Create database user
   - Set username and password
   - Grant read/write permissions

3. **Network Access**
   - Add IP address `0.0.0.0/0` (allow all)
   - Or add specific IPs for security

4. **Get Connection String**
   - Click "Connect"
   - Choose "Connect your application"
   - Copy the connection string
   - Replace `<password>` with your actual password

## 🧪 Testing Deployment

### Health Check
```bash
curl https://your-backend-url.com/health
```

Expected response:
```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "openai": true,
  "sessions": 0
}
```

### Test Authentication
```bash
# Test signup
curl -X POST https://your-backend-url.com/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123"}'
```

### Test Chat (requires auth token)
```bash
# Test chat with auth
curl -X POST https://your-backend-url.com/chat \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{"message":"Hello, my name is John"}'
```

## 🔍 Troubleshooting

### Common Issues

1. **CORS Errors**
   - Check CORS configuration
   - Ensure frontend URL is in allowed origins

2. **MongoDB Connection Issues**
   - Verify connection string
   - Check network access settings
   - Ensure database user has correct permissions

3. **OpenAI API Errors**
   - Verify API key is correct
   - Check API key has GPT-4 access
   - Monitor usage limits

4. **Environment Variables**
   - Ensure all required variables are set
   - Check for typos in variable names
   - Restart service after adding variables

### Logs and Monitoring

- **Vercel**: Check deployment logs in dashboard
- **Render**: View logs in service dashboard
- **Railway**: Monitor logs in real-time
- **Heroku**: Use `heroku logs --tail`

## 📊 Performance Optimization

### Frontend
- Enable Vercel's edge caching
- Optimize images and assets
- Use CDN for static files

### Backend
- Enable compression middleware
- Implement caching for static responses
- Monitor API response times

## 🔒 Security Checklist

- [ ] Environment variables are set
- [ ] CORS is properly configured
- [ ] Rate limiting is enabled
- [ ] Input validation is active
- [ ] JWT secret is secure
- [ ] MongoDB connection is secure
- [ ] HTTPS is enabled
- [ ] Security headers are set

## 📈 Scaling Considerations

### When to Scale
- Monitor response times
- Check error rates
- Track concurrent users

### Scaling Options
- **Vercel**: Automatic scaling
- **Render**: Upgrade to paid plan
- **Railway**: Auto-scaling available
- **Heroku**: Dyno scaling

## 🎉 Success!

Once deployed, your Fido SBA Copilot will be available at:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-backend.onrender.com`

Share your app with the world! 🚀 
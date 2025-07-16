# 🔑 API Keys & Database Setup Guide

## 1. OpenAI API Key Setup

### Step 1: Get OpenAI API Key
1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Sign up or log in to your account
3. Navigate to **API Keys** section
4. Click **"Create new secret key"**
5. Copy the key (starts with `sk-`)
6. **Important**: You need GPT-4 access (may require payment)

### Step 2: Add to Environment
```bash
# In your .env file
OPENAI_API_KEY=sk-your-actual-key-here
```

### Step 3: Verify Access
```bash
# Test API key (optional)
curl -H "Authorization: Bearer sk-your-key" https://api.openai.com/v1/models
```

## 2. MongoDB Database Setup

### Option A: MongoDB Atlas (Recommended)
1. Go to [MongoDB Atlas](https://cloud.mongodb.com/)
2. Create free account
3. Create new cluster (M0 free tier)
4. Create database user:
   - Database Access → Add New User
   - Username: `fidouser`
   - Password: Generate secure password
5. Configure network access:
   - Network Access → Add IP Address
   - Add `0.0.0.0/0` (allow all) for testing
6. Get connection string:
   - Clusters → Connect → Connect your application
   - Copy connection string

### Option B: Local MongoDB (Development)
```bash
# Install MongoDB locally
# macOS with Homebrew
brew install mongodb-community

# Ubuntu/Debian
sudo apt-get install mongodb

# Start MongoDB
mongod --dbpath /path/to/data
```

### Step 4: Configure Database
```bash
# In your .env file
MONGODB_URI=mongodb+srv://fidouser:your-password@cluster.mongodb.net/fido-sba-copilot
```

## 3. JWT Secret Setup

### Generate Secure JWT Secret
```bash
# Generate random 64-character string
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

### Add to Environment
```bash
# In your .env file
JWT_SECRET=your-generated-secret-here
```

## 4. Complete .env File Example

```bash
# Environment Configuration
NODE_ENV=development

# OpenAI Configuration
OPENAI_API_KEY=sk-your-openai-key-here

# Database Configuration
MONGODB_URI=mongodb+srv://fidouser:password@cluster.mongodb.net/fido-sba-copilot

# JWT Configuration
JWT_SECRET=your-64-character-hex-secret-here

# Server Configuration
PORT=3000
```

## 5. Test Local Setup

### Start Backend
```bash
cd backend
npm install
npm start
```

### Test Health Check
```bash
curl http://localhost:3000/health
```

### Start Frontend
```bash
# In another terminal
cd frontend
python3 -m http.server 5500
```

### Test Complete Application
1. Open http://localhost:5500
2. Create account
3. Send test message to chat

## 6. Production Deployment

### Backend (Render/Railway/Heroku)
1. Connect your GitHub repository
2. Set **Root Directory**: `backend`
3. Set **Build Command**: `npm install`
4. Set **Start Command**: `npm start`
5. Add environment variables in dashboard:
   - `NODE_ENV=production`
   - `OPENAI_API_KEY=sk-your-key`
   - `MONGODB_URI=mongodb+srv://...`
   - `JWT_SECRET=your-secret`
   - `PORT=10000` (or platform default)

### Frontend (Vercel/Netlify)
1. Connect your GitHub repository
2. Set **Root Directory**: `frontend`
3. **Build Command**: Leave empty (static files)
4. **Publish Directory**: Leave empty or `.`
5. Update `frontend/public/config.js` with production backend URL

## 7. Security Checklist

- [ ] ✅ API keys in environment variables (not code)
- [ ] ✅ Database user has minimal permissions
- [ ] ✅ JWT secret is randomly generated
- [ ] ✅ MongoDB network access configured
- [ ] ✅ CORS origins set for production
- [ ] ✅ Rate limiting enabled
- [ ] ✅ Input validation active

## 8. Common Issues & Solutions

### OpenAI API Issues
- **Error 429**: Rate limit exceeded → Wait or upgrade plan
- **Error 401**: Invalid API key → Regenerate key
- **Error 403**: No GPT-4 access → Contact OpenAI support

### MongoDB Issues
- **Connection timeout**: Check network access whitelist
- **Authentication failed**: Verify username/password
- **Database not found**: MongoDB will create automatically

### JWT Issues
- **Token expired**: Tokens expire after 24 hours (re-login)
- **Invalid token**: Secret mismatch between sessions

## 9. Cost Estimates

### OpenAI API
- **GPT-4**: ~$0.03-0.06 per 1K tokens
- **Monthly estimate**: $10-50 for moderate usage

### MongoDB Atlas
- **M0 Free tier**: 512MB storage (good for testing)
- **M2 Shared**: $9/month (production ready)

### Hosting
- **Render**: Free tier available
- **Vercel**: Free tier for frontend
- **Railway**: $5/month with usage

## 10. Next Steps

1. **Set up accounts** for all services
2. **Configure environment variables** locally
3. **Test everything** locally first
4. **Deploy to staging** environment
5. **Test deployed application**
6. **Configure production monitoring**

---

**Security Note**: Never commit `.env` files to version control. The `.env` file is already in `.gitignore`.
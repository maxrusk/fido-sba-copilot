# 🚀 Quick Start Guide - Deploy in 15 Minutes

## Step 1: Get Your API Keys (5 minutes)

### OpenAI API Key
1. Go to [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. Sign up/login
3. Click "Create new secret key"
4. Copy the key (starts with `sk-`)

### MongoDB Atlas (Free)
1. Go to [cloud.mongodb.com](https://cloud.mongodb.com)
2. Sign up and create a free cluster
3. Click "Connect" → "Connect your application"
4. Copy the connection string
5. Replace `<password>` with your actual password

## Step 2: Deploy Backend to Render (5 minutes)

1. Go to [render.com](https://render.com)
2. Sign up with GitHub
3. Click "New +" → "Web Service"
4. Connect your GitHub repository
5. Configure:
   - **Name**: `fido-backend`
   - **Root Directory**: `backend`
   - **Build Command**: `npm install`
   - **Start Command**: `node index.js`
6. Add Environment Variables:
   ```
   OPENAI_API_KEY=sk-your-actual-key-here
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/fido?retryWrites=true&w=majority
   JWT_SECRET=your-secure-random-string-here
   NODE_ENV=production
   PORT=10000
   ```
7. Click "Create Web Service"
8. **Copy your backend URL** (e.g., `https://fido-backend-abc123.onrender.com`)

## Step 3: Update Frontend Config (1 minute)

Edit `frontend/public/config.js`:
```javascript
// Replace YOUR-RENDER-URL with your actual Render URL
: 'https://your-actual-render-url.onrender.com',
```

## Step 4: Deploy Frontend to Vercel (4 minutes)

1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. Click "New Project"
4. Import your GitHub repository
5. Configure:
   - **Root Directory**: `frontend`
   - **Framework Preset**: Other
6. Click "Deploy"

## 🎉 Done!

Your app will be live at:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-backend.onrender.com`

## 🧪 Test Your Deployment

1. Visit your frontend URL
2. Sign up for a new account
3. Start chatting with Fido
4. Test the export functionality

## 🚨 Troubleshooting

- **CORS errors**: Check your backend URL in `frontend/public/config.js`
- **Database errors**: Verify your MongoDB connection string
- **OpenAI errors**: Check your API key and billing status

## 📞 Need Help?

Check the detailed guides:
- `DEPLOYMENT_SETUP.md` - Complete deployment guide
- `DEPLOYMENT_CHECKLIST.md` - Step-by-step checklist
- Run `npm run deploy:check` to validate your setup

---

**🎯 Your Fido SBA Copilot will be live in 15 minutes!**
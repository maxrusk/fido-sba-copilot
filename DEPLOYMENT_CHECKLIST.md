# 🚀 Deployment Checklist - Vercel + Render

Follow this checklist to deploy your Fido SBA Copilot to production.

## 📋 **Prerequisites Checklist**

- [ ] GitHub repository created and code pushed ✅
- [ ] OpenAI API key with GPT-4 access
- [ ] MongoDB Atlas cluster set up
- [ ] Environment variables ready

---

## 🔧 **Step 1: Deploy Backend to Render**

### **1.1 Create Render Account**
- [ ] Go to [render.com](https://render.com)
- [ ] Sign up with GitHub account
- [ ] Authorize Render to access repositories

### **1.2 Create Web Service**
- [ ] Click **"New +"** → **"Web Service"**
- [ ] Connect repository: `maxrusk/fido-sba-copilot`
- [ ] Configure settings:
  - **Name**: `fido-backend`
  - **Root Directory**: `backend`
  - **Environment**: `Node`
  - **Build Command**: `npm install`
  - **Start Command**: `node index.js`

### **1.3 Add Environment Variables**
Add these in Render dashboard:
```
OPENAI_API_KEY=your_openai_api_key_here
MONGODB_URI=your_mongodb_atlas_connection_string
JWT_SECRET=your_secure_jwt_secret_key
NODE_ENV=production
PORT=10000
```

### **1.4 Deploy Backend**
- [ ] Click **"Create Web Service"**
- [ ] Wait for deployment (2-3 minutes)
- [ ] Copy the URL: `https://fido-backend.onrender.com` (or your custom URL)

---

## 🌐 **Step 2: Update Frontend Configuration**

### **2.1 Update API URL**
- [ ] Open `frontend/public/config.js`
- [ ] Replace the production URL with your Render backend URL:
```javascript
API_BASE: window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
  ? 'http://localhost:3000'  // Development
  : 'https://YOUR-RENDER-URL.onrender.com', // Production - UPDATE THIS
```

### **2.2 Commit and Push Changes**
```bash
git add .
git commit -m "feat: update API URL for production deployment"
git push origin main
```

---

## 🎨 **Step 3: Deploy Frontend to Vercel**

### **3.1 Create Vercel Account**
- [ ] Go to [vercel.com](https://vercel.com)
- [ ] Sign up with GitHub account
- [ ] Authorize Vercel to access repositories

### **3.2 Import Project**
- [ ] Click **"New Project"**
- [ ] Import repository: `maxrusk/fido-sba-copilot`
- [ ] Configure settings:
  - **Framework Preset**: `Other`
  - **Root Directory**: `frontend`
  - **Build Command**: Leave empty
  - **Output Directory**: Leave empty

### **3.3 Deploy Frontend**
- [ ] Click **"Deploy"**
- [ ] Wait for deployment (1-2 minutes)
- [ ] Copy the URL: `https://fido-sba-copilot.vercel.app` (or your custom URL)

---

## 🔗 **Step 4: Test Your Deployment**

### **4.1 Test Backend Health**
```bash
curl https://your-render-url.onrender.com/health
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

### **4.2 Test Frontend**
- [ ] Visit your Vercel URL
- [ ] Test signup/login functionality
- [ ] Test chat functionality
- [ ] Test export functionality

### **4.3 Test Full Flow**
- [ ] Create a new account
- [ ] Start a conversation with Fido
- [ ] Go through onboarding questions
- [ ] Test business plan building
- [ ] Test export functionality

---

## 🔧 **Step 5: Configure CORS (if needed)**

If you get CORS errors, update your backend CORS settings in `backend/index.js`:

```javascript
const corsOptions = {
  origin: process.env.NODE_ENV === 'production' 
    ? ['https://your-vercel-url.vercel.app'] // Your Vercel frontend URL
    : ['http://localhost:3000', 'http://127.0.0.1:3000'],
  credentials: true,
  optionsSuccessStatus: 200
};
```

---

## 🎯 **Step 6: Final Verification**

### **6.1 Check All Features**
- [ ] ✅ Authentication (signup/login)
- [ ] ✅ Chat functionality
- [ ] ✅ Business plan building
- [ ] ✅ Export functionality
- [ ] ✅ Error handling
- [ ] ✅ Responsive design

### **6.2 Performance Check**
- [ ] ✅ Page load time < 3 seconds
- [ ] ✅ Chat responses < 5 seconds
- [ ] ✅ Export downloads work
- [ ] ✅ Mobile responsiveness

### **6.3 Security Check**
- [ ] ✅ HTTPS enabled
- [ ] ✅ Environment variables secure
- [ ] ✅ Rate limiting working
- [ ] ✅ Input validation active

---

## 🚀 **Step 7: Go Live!**

### **7.1 Share Your App**
- [ ] Add topics to GitHub repository
- [ ] Create a demo video
- [ ] Share on social media
- [ ] Submit to developer communities

### **7.2 Monitor Performance**
- [ ] Set up monitoring (optional)
- [ ] Check Render/Vercel dashboards
- [ ] Monitor API usage
- [ ] Track user feedback

---

## 📞 **Troubleshooting**

### **Common Issues:**

1. **CORS Errors**
   - Check CORS configuration in backend
   - Ensure frontend URL is in allowed origins

2. **Authentication Issues**
   - Verify JWT_SECRET is set
   - Check MongoDB connection

3. **OpenAI API Errors**
   - Verify API key has GPT-4 access
   - Check usage limits

4. **Deployment Failures**
   - Check build logs in Render/Vercel
   - Verify environment variables
   - Check file paths and dependencies

---

## 🎉 **Success!**

Your Fido SBA Copilot is now live at:
- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-backend.onrender.com`

**Share your app and start helping small business owners access SBA loans! 🐕✨** 
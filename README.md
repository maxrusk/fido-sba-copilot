# �� Fido SBA Copilot

> **Your AI-powered SBA loan guidance assistant** - Helping small business owners, especially first-time founders and immigrants, understand and access capital through SBA loan programs.

[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![Express](https://img.shields.io/badge/Express-4.x-blue.svg)](https://expressjs.com/)
[![OpenAI](https://img.shields.io/badge/OpenAI-GPT--4-orange.svg)](https://openai.com/)
[![MongoDB](https://img.shields.io/badge/MongoDB-Atlas-green.svg)](https://www.mongodb.com/atlas)

## ✨ Features

### 🤖 **AI-Powered Guidance**
- **Personalized SBA Loan Recommendations** based on your situation
- **Step-by-step Business Plan Builder** with interactive guidance
- **Multi-language Support** (English, Spanish, Vietnamese, Chinese)
- **Session Memory** - Pick up where you left off

### 🔐 **Secure Authentication**
- **Email/Password Signup & Login**
- **JWT-based Authentication**
- **Secure Password Hashing** with bcrypt
- **Session Management**

### 📊 **Business Plan Features**
- **9-Section Business Plan Builder**:
  - Executive Summary
  - Business Description
  - Market Analysis
  - Products & Services
  - Marketing Plan
  - Operations Plan
  - Financial Projections
  - Funding Request
  - Owner Bio
- **Export Options**: Text, PDF, JSON formats
- **Progress Tracking** and completion summaries

### 🎨 **Modern UI/UX**
- **Glassmorphism Design** with smooth animations
- **Responsive Layout** - works on all devices
- **Loading States** and error handling
- **Custom Fido Logo** and branding

### 🛡️ **Production-Ready**
- **Rate Limiting** and security headers
- **Input Validation** and sanitization
- **Error Handling** with user-friendly messages
- **Health Check Endpoints**
- **MongoDB Atlas** cloud database

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- MongoDB Atlas account
- OpenAI API key

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/fido-sba-copilot.git
cd fido-sba-copilot
```

### 2. Install Dependencies
```bash
# Install backend dependencies
cd backend
npm install

# Install frontend dependencies (if any)
cd ../frontend
npm install  # if you have a package.json
```

### 3. Environment Setup
Create a `.env` file in the `backend/` directory:
```env
# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key_here

# MongoDB Atlas
MONGODB_URI=your_mongodb_atlas_connection_string

# JWT Secret
JWT_SECRET=your_jwt_secret_key_here

# Environment
NODE_ENV=development
PORT=3000
```

### 4. Start the Application
```bash
# Start backend server
cd backend
node index.js

# Open frontend in browser
open frontend/index.html
```

The backend will be running on `http://localhost:3000`

## 📁 Project Structure

```
fido-sba-copilot/
├── backend/
│   ├── index.js              # Main server file
│   ├── models/
│   │   ├── User.js           # User model (Mongoose)
│   │   ├── Session.js        # Session model
│   │   └── Message.js        # Message model
│   ├── package.json
│   └── .env                  # Environment variables
├── frontend/
│   ├── index.html            # Main HTML file
│   └── public/
│       ├── main.js           # Main JavaScript
│       ├── auth.js           # Authentication logic
│       └── styles.css        # Styling
├── scripts/
│   └── deploy-check.js       # Deployment validation
├── README.md
└── .gitignore
```

## 🔧 API Endpoints

### Authentication
- `POST /auth/signup` - User registration
- `POST /auth/login` - User login

### Chat & Business Plan
- `POST /chat` - Send message to Fido (requires auth)
- `POST /export-plan` - Export business plan

### System
- `GET /health` - Health check endpoint

## 🌐 Deployment

### Frontend (Vercel)
1. Push your code to GitHub
2. Connect your repo to [Vercel](https://vercel.com)
3. Set the root directory to `frontend/`
4. Deploy!

### Backend (Render/Railway/Heroku)
1. Push your code to GitHub
2. Connect your repo to your chosen platform
3. Set the root directory to `backend/`
4. Add environment variables
5. Deploy!

### Environment Variables for Production
```env
OPENAI_API_KEY=your_production_openai_key
MONGODB_URI=your_production_mongodb_uri
JWT_SECRET=your_production_jwt_secret
NODE_ENV=production
```

## 🎯 Example Usage

### Starting a Conversation
```
User: "Hi, I'm interested in getting an SBA loan."
Fido: "Welcome, small business owner. I'm your SBA Loan Guidance Agent..."

User: "My name is Maria."
Fido: "Welcome, small business owner. That's a great start, Maria..."
```

### Building a Business Plan
```
User: "Let's start the business plan."
Fido: "Great choice! The first section is the Executive Summary..."
```

### Exporting Results
```
User: "Can I download my business plan?"
Fido: "Absolutely! You can export your plan as text, PDF, or JSON..."
```

## 🔒 Security Features

- **Helmet.js** for security headers
- **Rate limiting** (100 requests/15min, 10 chat requests/min)
- **Input validation** and sanitization
- **CORS protection**
- **JWT authentication**
- **Password hashing** with bcrypt

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **OpenAI** for GPT-4 API
- **MongoDB Atlas** for cloud database
- **Express.js** for the backend framework
- **Vercel** for frontend hosting

## 📞 Support

If you have any questions or need help:
- Open an issue on GitHub
- Check the documentation
- Review the example conversations

---

**Made with ❤️ for small business owners everywhere** 
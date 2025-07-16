#!/bin/bash

# Fido SBA Copilot - Quick Start Script
# This script helps you set up the development environment quickly

set -e

echo "🐕 Fido SBA Copilot - Quick Start Setup"
echo "========================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18 or higher is required. Current version: $(node -v)"
    exit 1
fi

echo "✅ Node.js $(node -v) detected"

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install
cd ..

echo "🔧 Setting up environment..."

# Create backend .env file if it doesn't exist
if [ ! -f "backend/.env" ]; then
    cp backend/.env.example backend/.env
    echo "✅ Created backend/.env file"
    echo "⚠️  Please edit backend/.env with your actual values:"
    echo "   - OPENAI_API_KEY: Your OpenAI API key"
    echo "   - MONGODB_URI: Your MongoDB connection string"
    echo "   - JWT_SECRET: A secure random string"
else
    echo "✅ backend/.env already exists"
fi

# Create .env file for Docker Compose if it doesn't exist
if [ ! -f ".env" ]; then
    echo "OPENAI_API_KEY=your_openai_key_here" > .env
    echo "JWT_SECRET=your_jwt_secret_here" >> .env
    echo "✅ Created .env file for Docker Compose"
    echo "⚠️  Please edit .env with your actual values"
else
    echo "✅ .env already exists"
fi

echo ""
echo "🎉 Setup complete! Next steps:"
echo ""
echo "1. Edit your environment files:"
echo "   - backend/.env (for local development)"
echo "   - .env (for Docker deployment)"
echo ""
echo "2. Start development server:"
echo "   npm run dev:full"
echo ""
echo "3. Or run with Docker:"
echo "   npm run docker:compose"
echo ""
echo "4. Before deploying, run:"
echo "   npm run deploy:check"
echo ""
echo "📚 For detailed deployment instructions, see:"
echo "   - DEPLOYMENT.md"
echo "   - DEPLOYMENT_SETUP.md"
echo "   - DEPLOYMENT_CHECKLIST.md"
echo ""
echo "🚀 Happy coding with Fido!"
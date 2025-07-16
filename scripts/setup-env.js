#!/usr/bin/env node

const fs = require('fs');
const crypto = require('crypto');
const readline = require('readline');

console.log('🔐 Fido SBA Copilot - Environment Setup Helper\n');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function generateJWTSecret() {
  return crypto.randomBytes(64).toString('hex');
}

function createEnvFile(answers) {
  const envContent = `# Environment Configuration
NODE_ENV=development

# OpenAI Configuration
OPENAI_API_KEY=${answers.openaiKey}

# Database Configuration
MONGODB_URI=${answers.mongoUri}

# JWT Configuration
JWT_SECRET=${answers.jwtSecret}

# Server Configuration
PORT=3000
`;

  fs.writeFileSync('.env', envContent);
  console.log('\n✅ .env file created successfully!');
}

async function setup() {
  const answers = {};
  
  console.log('This script will help you create a .env file with your configuration.');
  console.log('⚠️  Never share these values with anyone!\n');

  // Generate JWT secret
  answers.jwtSecret = generateJWTSecret();
  console.log('✅ Generated secure JWT secret');

  // Get OpenAI API key
  answers.openaiKey = await new Promise((resolve) => {
    rl.question('🔑 Enter your OpenAI API key (starts with sk-): ', (answer) => {
      if (!answer.startsWith('sk-')) {
        console.log('❌ Invalid OpenAI API key format. Should start with "sk-"');
        process.exit(1);
      }
      resolve(answer);
    });
  });

  // Get MongoDB URI
  answers.mongoUri = await new Promise((resolve) => {
    rl.question('🗄️  Enter your MongoDB connection string: ', (answer) => {
      if (!answer.includes('mongodb')) {
        console.log('❌ Invalid MongoDB URI format. Should start with "mongodb://" or "mongodb+srv://"');
        process.exit(1);
      }
      resolve(answer);
    });
  });

  rl.close();

  // Create .env file
  createEnvFile(answers);

  console.log('\n📋 Next steps:');
  console.log('1. cd backend && npm install');
  console.log('2. npm start');
  console.log('3. Test: curl http://localhost:3000/health');
  console.log('4. Open frontend: python3 -m http.server 5500');
  console.log('\n🔒 Security reminder: Never commit .env files to version control!');
}

// Check if .env already exists
if (fs.existsSync('.env')) {
  console.log('⚠️  .env file already exists. Remove it first if you want to recreate it.');
  process.exit(1);
}

setup().catch(console.error);
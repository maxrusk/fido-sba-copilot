// MongoDB initialization script for Fido SBA Copilot

// Switch to the fido database
db = db.getSiblingDB('fido');

// Create collections with validation
db.createCollection('users', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['name', 'email', 'password'],
      properties: {
        name: {
          bsonType: 'string',
          description: 'User full name - required'
        },
        email: {
          bsonType: 'string',
          pattern: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$',
          description: 'Valid email address - required'
        },
        password: {
          bsonType: 'string',
          minLength: 6,
          description: 'Hashed password - required'
        },
        createdAt: {
          bsonType: 'date',
          description: 'Account creation timestamp'
        }
      }
    }
  }
});

db.createCollection('chatsessions', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['userId', 'messages'],
      properties: {
        userId: {
          bsonType: 'objectId',
          description: 'Reference to user - required'
        },
        messages: {
          bsonType: 'array',
          description: 'Array of chat messages - required',
          items: {
            bsonType: 'object',
            required: ['role', 'content'],
            properties: {
              role: {
                enum: ['user', 'assistant'],
                description: 'Message role - required'
              },
              content: {
                bsonType: 'string',
                description: 'Message content - required'
              },
              timestamp: {
                bsonType: 'date',
                description: 'Message timestamp'
              }
            }
          }
        },
        businessPlan: {
          bsonType: 'object',
          description: 'Business plan data extracted from conversation',
          properties: {
            businessName: { bsonType: 'string' },
            businessType: { bsonType: 'string' },
            industry: { bsonType: 'string' },
            location: { bsonType: 'string' },
            description: { bsonType: 'string' },
            targetMarket: { bsonType: 'string' },
            competition: { bsonType: 'string' },
            funding: { bsonType: 'string' },
            timeline: { bsonType: 'string' }
          }
        },
        createdAt: {
          bsonType: 'date',
          description: 'Session creation timestamp'
        },
        updatedAt: {
          bsonType: 'date',
          description: 'Session last update timestamp'
        }
      }
    }
  }
});

// Create indexes for better performance
db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ createdAt: 1 });

db.chatsessions.createIndex({ userId: 1 });
db.chatsessions.createIndex({ createdAt: 1 });
db.chatsessions.createIndex({ updatedAt: 1 });

// Create a sample admin user (optional - remove in production)
// db.users.insertOne({
//   name: 'Admin User',
//   email: 'admin@fido.com',
//   password: '$2a$12$example.hashed.password.here',
//   createdAt: new Date()
// });

print('MongoDB initialization completed for Fido SBA Copilot');
print('Collections created: users, chatsessions');
print('Indexes created for optimal performance');
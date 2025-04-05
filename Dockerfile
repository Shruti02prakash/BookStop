# Stage 1: Build the frontend (React)
FROM node:16 AS frontend-build

# Set the working directory for frontend
WORKDIR /frontend

# Copy package.json and package-lock.json for frontend
COPY frontend/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend files
COPY frontend/ .

# Build the React app for production
RUN npm run build


# Stage 2: Set up the backend (Node.js API)
FROM node:16 AS backend

# Set working directory for backend
WORKDIR /backend

# Copy package.json and package-lock.json for backend
COPY backend/package*.json ./

# Install backend dependencies
RUN npm install

# Copy the rest of the backend files
COPY backend/ .

# Stage 3: Serve the application (both frontend and backend)
FROM node:16

# Set working directory
WORKDIR /app

# Copy the frontend build from the previous stage
COPY --from=frontend-build /frontend/build /app/frontend

# Copy the backend files from the previous stage
COPY --from=backend /backend /app/backend

# Install global dependencies
RUN npm install -g serve

# Expose port 5000 for backend and port 3000 for frontend
EXPOSE 5000
EXPOSE 3000

# Run the backend server and serve the frontend
CMD ["sh", "-c", "node /app/backend/server.js & serve -s /app/frontend"]

# Step 1: Use the official Node.js image as the base image
FROM node:18 AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# Step 4: Install the project dependencies
RUN npm install

# Step 5: Copy the rest of the application files
COPY . .

# Step 6: Build the React app for production
RUN npm run build

# Step 7: Create a production-ready container
FROM nginx:alpine

# Step 8: Copy the build output to the nginx server
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose the default port for nginx
EXPOSE 80

# Step 10: Start the nginx server
CMD ["nginx", "-g", "daemon off;"]

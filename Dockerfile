# module install
FROM node:16.14.2-alpine3.15 as builder
# set working directory
WORKDIR /app
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
COPY package-lock.json ./

# npm clean install
RUN npm ci --silent
RUN npm install react-scripts@5.0.0 -g --silent
COPY . ./

# generate production build
RUN npm run build

# use nginx to render app
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD nginx -g 'daemon off;'



# build from CMD
# docker build . -t chefdigitaldemo/cicd-demo-react:latest

# test
# docker run -it --rm -p 3000:80 chefdigitaldemo/cicd-demo-react:latest

# minikube
# kubectl apply -f deployment.yaml
# kubectl get pods
# kubectl get svc
# kubectl get deployment
# open $(minikube ip):NodePort in web browser
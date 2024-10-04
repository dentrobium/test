# dev/Dockerfile

# 베이스 이미지
FROM node:18-alpine

# 작업 디렉토리 생성
WORKDIR /app

# 패키지 설치
COPY package.json package-lock.json ./
RUN npm install

# 소스 코드 복사
COPY . .

# Next.js 개발 서버 실행
CMD ["npm", "run", "dev"]

# 컨테이너의 3000 포트 노출
EXPOSE 3000

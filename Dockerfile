# main/Dockerfile

# 베이스 이미지
FROM node:18-alpine AS builder

# 작업 디렉토리 생성
WORKDIR /app

# 패키지 설치
COPY package.json package-lock.json ./
RUN npm install

# 소스 코드 복사 및 빌드
COPY . .
RUN npm run build

# 프로덕션 이미지 설정
FROM node:18-alpine

WORKDIR /app

# 빌드된 파일만 복사
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./

# 프로덕션 패키지 설치
RUN npm install --production

# Next.js 서버 실행
CMD ["npm", "start"]

# 컨테이너의 3000 포트 노출
EXPOSE 3000

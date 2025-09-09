-- create SCHEMA app;


CREATE EXTENSION IF NOT EXISTS "pgcrypto";  




CREATE TABLE books (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    publish_year INT,
    description TEXT,
    cover_url TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_pw TEXT NOT NULL,
    bio TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    book_id UUID REFERENCES books (id) ON DELETE CASCADE,
    rating SMALLINT CHECK (rating BETWEEN 1 AND 10),
    review_text TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE likes (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    review_id UUID REFERENCES reviews(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (user_id, review_id)
);


CREATE TABLE watchlist (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (user_id, book_id)
);


CREATE TABLE favorites (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (user_id, book_id)
);



CREATE TABLE follow (
    follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
    following_id UUID REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (follower_id, following_id),
    CHECK (follower_id <> following_id) -- self-follow constraint
);


CREATE TABLE genres (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE book_genres ( -- RElation book and genre
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    genre_id UUID REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, genre_id)
);


CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users (id) ON DELETE CASCADE,
    review_id UUID REFERENCES reviews(id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);




SELECT * from reviews;









-- DROP TABLE IF EXISTS books;
-- DROP TABLE IF EXISTS users;








require "dotenv"
Dotenv.load
require "roda"
require "./lucid_dream"

run LucidDream.freeze.app

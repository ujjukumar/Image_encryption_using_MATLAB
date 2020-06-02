function [key] = randKeyGen(n)
rng(n)
key = uint8(randi([0 255], n, 1));
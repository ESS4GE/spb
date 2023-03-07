FROM debian:latest
COPY be .
RUN chmod +x be
CMD ./be

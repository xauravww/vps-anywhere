FROM alpine:latest

# Install ttyd and bash
RUN apk add --no-cache ttyd bash

# Expose the port ttyd will run on
EXPOSE 7681

# Start ttyd with bash
CMD ["ttyd", "-p", "7681", "bash"]

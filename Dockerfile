FROM storjlabs/gateway

COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT ["run.sh"]

CMD ["./gateway", "run"]

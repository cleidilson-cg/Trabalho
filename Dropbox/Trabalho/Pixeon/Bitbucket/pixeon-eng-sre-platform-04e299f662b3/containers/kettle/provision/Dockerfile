# Provisioning image

FROM	pdi-base:latest

RUN	useradd -ms /bin/bash pentaho
RUN	chown -R pentaho /opt/
WORKDIR	/home/pentaho

# add ssh key
COPY	build/ssh/* /home/pentaho/.ssh/
RUN	chown -R pentaho /home/pentaho/

USER	pentaho
#RUN     eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
RUN     /bin/echo "bitbucket.org,104.192.143.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==" >> ~/.ssh/known_hosts

# add kettle.properties
COPY	build/properties/kettle.properties .kettle/

# add plugins, drivers, jdbc.properties
WORKDIR	/opt/data-integration
COPY	build/plugins/* plugins/
COPY	build/drivers/* lib/
COPY	build/properties/jdbc.properties simple-jndi/

# add entrypoint
COPY	build/entry/script.sh .
USER	root
RUN	chmod +x script.sh
USER	pentaho

# create mount directory

ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["script.sh"]

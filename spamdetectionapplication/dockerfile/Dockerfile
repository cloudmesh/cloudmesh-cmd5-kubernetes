FROM r-base
COPY . ~/myscripts
WORKDIR ~/myscripts
RUN Rscript -e "install.packages('tm', repos='http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('e1071',repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('RWeka',repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('ada',repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('rbenchmark',repos = 'http://cran.us.r-project.org')"
CMD ["Rscript","spamdetection.r"]

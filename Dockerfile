FROM ubuntu:bionic

RUN set -xe \
	&& apt-get update \
	&& apt-get -y install curl git jq npm python-pip python3-pip unzip \
  && rm -rf /var/lib/apt/lists/* \
	&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
	&& npm install npm@latest -g \
	&& pip install ansible awscli flake8 pep8-naming future pipenv pydocstyle pylint runway sceptre stacker yamllint \
	&& curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk \
	&& npm install -g serverless \
	&& git clone https://github.com/kamatama41/tfenv.git ~/.tfenv \
	&& ln -s ~/.tfenv/bin/* /usr/local/bin \
	&& tfenv install $(curl https://releases.hashicorp.com/index.json | jq -r '.terraform.versions | to_entries | map(select(.key | contains ("-") | not)) | sort_by(.key | split(".") | map(tonumber))[-1].value.builds | to_entries | map(select(.value.arch | contains("amd64"))) | map(select(.value.os | contains("linux")))[0].value.version')

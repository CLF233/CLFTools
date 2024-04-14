#!/bin/bash
#By CLF
#2023.6.12,23:00.

gh_config() {
  echo_blue "[I]: Enter \"${CODETOEXIT}\" to go back to the last page."
  get_input "Input your GitHub nickname: " NAME
  if_empty_run "$NAME" gh_config
  if [[ "${NAME}" == "${CODETOEXIT}" ]];then
    main
  fi
  get_input "Input a email you want to use for commit: " EMAIL
  if_empty_red "$EMAIL" gh_config
  if [[ "${EMAIL}" == "${CODETOEXIT}" ]];then
    main
  fi

	set -e
	set -x
	#配置默认初始仓库分支为main
	git config --global init.defaultBranch "main"
	#配置username(可改为你自己的GitHub用户名)
	git config --global user.name "$NAME"
	#配置用户邮箱(可改为你自己注册GitHub邮箱)
	git config --global user.email "$EMAIL"
	#配置最大缓冲区大小为10G(防止推送/拉取失败)
	git config --global http.postBuffer 10737418240
	git config --global https.postBuffer 10737418240
  echo_green "[I]: Success."
  sleep 3
  main
}
##########

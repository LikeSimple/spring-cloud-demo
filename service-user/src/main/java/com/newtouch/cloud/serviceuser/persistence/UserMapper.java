package com.newtouch.cloud.serviceuser.persistence;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends tk.mybatis.mapper.common.Mapper<AppUser> {
}

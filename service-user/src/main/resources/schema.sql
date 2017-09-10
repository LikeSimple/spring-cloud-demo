DROP TABLE IF EXISTS `app_user`;

CREATE TABLE `app_user` (
  `id`                CHAR(22)     NOT NULL DEFAULT '',
  `username`          VARCHAR(255) NOT NULL
  COMMENT '登录名',
  `email`             VARCHAR(255) NOT NULL
  COMMENT 'Email',
  `password`          VARCHAR(80)  NOT NULL
  COMMENT '登录密码',
  `enabled`           TINYINT(1)   NOT NULL DEFAULT '1'
  COMMENT '账号有效标志',
  `locked`            TINYINT(1)   NOT NULL DEFAULT '0'
  COMMENT '账号锁定标志',
  `account_expire`    DATETIME              DEFAULT NULL
  COMMENT '用户名过期时间',
  `credential_expire` DATETIME              DEFAULT NULL
  COMMENT '密码过期时间',
  `created_time`      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time`     TIMESTAMP    NULL     DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uni_au_username` (`username`),
  UNIQUE KEY `idx_uni_au_email` (`email`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='应用用户';
/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : sleuth

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-04 13:15:00
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for zipkin_annotations
-- ----------------------------
CREATE TABLE `zipkin_annotations` (
  `trace_id`              BIGINT(20)   NOT NULL
  COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id`               BIGINT(20)   NOT NULL
  COMMENT 'coincides with zipkin_spans.id',
  `a_key`                 VARCHAR(255) NOT NULL
  COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value`               BLOB COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type`                INT(11)      NOT NULL
  COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp`           BIGINT(20)   DEFAULT NULL
  COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4`         INT(11)      DEFAULT NULL
  COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6`         BINARY(16)   DEFAULT NULL
  COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port`         SMALLINT(6)  DEFAULT NULL
  COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` VARCHAR(255) DEFAULT NULL
  COMMENT 'Null when Binary/Annotation.endpoint is null',
  UNIQUE KEY `trace_id` (`trace_id`, `span_id`, `a_key`, `a_timestamp`)
    COMMENT 'Ignore insert on duplicate',
  KEY `trace_id_2` (`trace_id`, `span_id`)
    COMMENT 'for joining with zipkin_spans',
  KEY `trace_id_3` (`trace_id`)
    COMMENT 'for getTraces/ByIds',
  KEY `endpoint_service_name` (`endpoint_service_name`)
    COMMENT 'for getTraces and getServiceNames',
  KEY `a_type` (`a_type`)
    COMMENT 'for getTraces',
  KEY `a_key` (`a_key`)
    COMMENT 'for getTraces'
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPRESSED;

-- ----------------------------
-- Table structure for zipkin_dependencies
-- ----------------------------
CREATE TABLE `zipkin_dependencies` (
  `day`        DATE         NOT NULL,
  `parent`     VARCHAR(255) NOT NULL,
  `child`      VARCHAR(255) NOT NULL,
  `call_count` BIGINT(20) DEFAULT NULL,
  UNIQUE KEY `day` (`day`, `parent`, `child`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPRESSED;

-- ----------------------------
-- Table structure for zipkin_spans
-- ----------------------------
CREATE TABLE `zipkin_spans` (
  `trace_id`  BIGINT(20)   NOT NULL,
  `id`        BIGINT(20)   NOT NULL,
  `name`      VARCHAR(255) NOT NULL,
  `parent_id` BIGINT(20) DEFAULT NULL,
  `debug`     BIT(1)     DEFAULT NULL,
  `start_ts`  BIGINT(20) DEFAULT NULL
  COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration`  BIGINT(20) DEFAULT NULL
  COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
  UNIQUE KEY `trace_id` (`trace_id`, `id`)
    COMMENT 'ignore insert on duplicate',
  KEY `trace_id_2` (`trace_id`, `id`)
    COMMENT 'for joining with zipkin_annotations',
  KEY `trace_id_3` (`trace_id`)
    COMMENT 'for getTracesByIds',
  KEY `name` (`name`)
    COMMENT 'for getTraces and getSpanNames',
  KEY `start_ts` (`start_ts`)
    COMMENT 'for getTraces ordering and range'
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = COMPRESSED;


-- 客户公司信息表
CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `company_name` varchar(100) NOT NULL COMMENT '公司全称',
  `type` varchar(10) NOT NULL COMMENT '类型',
  `name` varchar(100) NOT NULL COMMENT '公司简称',
  `province` varchar(20) NOT NULL COMMENT '省份',
  `city` varchar(20) NOT NULL COMMENT '城市',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `linkman_name` varchar(50) NOT NULL COMMENT '联系人姓名',
  `linkman_tel` varchar(50) NOT NULL COMMENT '联系人电话',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `remark` varchar(500) NOT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司信息表';

-- 供应商公司信息表
CREATE TABLE `provider_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `company_name` varchar(100) NOT NULL COMMENT '公司全称',
  `name` varchar(100) NOT NULL COMMENT '公司简称',
  `province` varchar(20) NOT NULL COMMENT '省份',
  `city` varchar(20) NOT NULL COMMENT '城市',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `linkman_name` varchar(50) NOT NULL COMMENT '联系人姓名',
  `linkman_tel` varchar(50) NOT NULL COMMENT '联系人电话',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `remark` varchar(500) NOT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商公司信息表';

-- 发票表
CREATE TABLE `invoice_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `company_id` int(11) NOT NULL COMMENT '所属公司',
  `type` int(11) NOT NULL COMMENT '我司0/客户1/供应商2',
  `taxpayer_code` varchar(100) NOT NULL COMMENT '纳税人识别号',
  `title` varchar(20) NOT NULL COMMENT '收票公司',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `tel` varchar(100) NOT NULL COMMENT '电话',
  `open_account_bank` varchar(100) NOT NULL COMMENT '开户银行',
  `account_code` varchar(100) NOT NULL COMMENT '银行账户号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票表';

-- 银行账户信息
CREATE TABLE `bank_account_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `company_id` int(11) NOT NULL COMMENT '所属公司',
  `type` int(11) NOT NULL COMMENT '我司0/客户1/供应商2',
  `account_name` varchar(100) NOT NULL COMMENT '账户名称',
  `bank_name` varchar(100) NOT NULL COMMENT '银行名称',
  `account_code` varchar(100) NOT NULL COMMENT '账户号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行账户信息';

-- 客户合同信息表
CREATE TABLE `customer_contract_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `customer_type` int(11) NOT NULL COMMENT '直客0/子客1',
  `business_type` varchar(50) NOT NULL COMMENT '业务类型',
  `contract_code` varchar(100) NOT NULL COMMENT '合同编号',
  `statistics_short_name` varchar(10) NOT NULL COMMENT '统计简称',
  `our_company_name` varchar(50) NOT NULL COMMENT '我方主体名称',
  `contract_start_time` datetime NOT NULL COMMENT '合同开始时间',
  `contract_end_time` datetime NOT NULL COMMENT '合同结束时间',
  `rebates` decimal(10,2) DEFAULT NULL COMMENT '返点',
  `orderfrom` int(11) DEFAULT NULL COMMENT '账期（天）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户合同信息表';

-- 供应商合同信息表
CREATE TABLE `provider_contract_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `customer_type` int(11) NOT NULL COMMENT '直客0/子客1',
  `business_type` varchar(50) NOT NULL COMMENT '业务类型',
  `contract_code` varchar(100) NOT NULL COMMENT '合同编号',
  `statistics_short_name` varchar(10) NOT NULL COMMENT '统计简称',
  `our_company_name` varchar(50) NOT NULL COMMENT '我方主体名称',
  `contract_start_time` datetime NOT NULL COMMENT '合同开始时间',
  `contract_end_time` datetime NOT NULL COMMENT '合同结束时间',
  `rebates` decimal(10,2) DEFAULT NULL COMMENT '返点',
  `orderfrom` int(11) DEFAULT NULL COMMENT '账期（天）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商合同信息表';

-- 点我账户表
CREATE TABLE `keepme_account_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `app_id` varchar(50) NOT NULL COMMENT 'APPID',
  `platform` varchar(50) NOT NULL COMMENT '投放平台',
  `keepme_account_name` varchar(50) NOT NULL COMMENT '账户名称',
  `keepme_account_id` varchar(100) NOT NULL COMMENT '账户ID',
  `provider_id` int(11) NOT NULL COMMENT '供应商ID',
  `provider_name` varchar(20) NOT NULL COMMENT '供应商名称',
  `qq` varchar(20) NOT NULL COMMENT '绑定QQ',
  `industry` varchar(20) NOT NULL COMMENT '行业',
  `generalize_link` varchar(200) NOT NULL COMMENT '推广链接',
  `services` varchar(50) NOT NULL COMMENT 'feed/分包/oCPA/DMP/联盟屏蔽/oCP留存/oCP订单',
  `subpackage` varchar(50) NOT NULL COMMENT '分包',
  `ocpa` varchar(50) NOT NULL COMMENT 'ocpa',
  `pass_status` varchar(50) NOT NULL COMMENT '通过状态 未审核 已通过 未通过',
  `pass_time` datetime DEFAULT NULL COMMENT '通过时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推广账户表';

-- 充值信息表
CREATE TABLE `recharge_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `generalize_id` int(11) NOT NULL COMMENT '推广账户ID',
  `app_id` varchar(50) NOT NULL COMMENT 'APPID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_name` varchar(150) NOT NULL COMMENT '客户名称',
  `provider_id` int(11) NOT NULL COMMENT '供应商ID',
  `provider_name` varchar(150) NOT NULL COMMENT '供应商名称',
  `our_rebates` decimal(10,2) NOT NULL COMMENT '我方返点',
  `customer_rebates` decimal(10,2) NOT NULL COMMENT '客户返点',
  `account_recharge` decimal(10,2) NOT NULL COMMENT '我方返点',
  `rebates_recharge` decimal(10,2) NOT NULL COMMENT '返点充值',
  `recharge_cost` decimal(10,2) NOT NULL COMMENT '充值成本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值信息表';

-- 发票记录表
CREATE TABLE `invoice_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `invoice_info_id`  int(11) NOT NULL COMMENT '发票信息表ID',
  `type` int(11) NOT NULL COMMENT '销售发票|媒介发票',
  `apply_name` varchar(50) NOT NULL COMMENT '申请人姓名',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_name` varchar(150) NOT NULL COMMENT '客户名称',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `platform` varchar(50) NOT NULL COMMENT '投放平台',
  `pay_time` datetime NOT NULL COMMENT '费用发生日期',
  `invoice_code` varchar(50) NOT NULL COMMENT '发票号',
  `open_time` datetime NOT NULL COMMENT '开票日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票记录表';

-- 收付款信息导入表
CREATE TABLE `return_pay_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `customer_id` int(11) NOT NULL COMMENT '统计单位ID',
  `customer_name` varchar(200) NOT NULL COMMENT '统计单位名称',
  `transact_time` datetime NOT NULL COMMENT '交易时间',
  `pay_money` decimal(10,2) DEFAULT 0 COMMENT '支出',
  `return_money` decimal(10,2) DEFAULT 0 COMMENT '收入',
  `surplus_money` decimal(10,2) NOT NULL COMMENT '余额',
  `currency` varchar(50) NOT NULL COMMENT '币种',
  `account_name` varchar(100)NOT NULL COMMENT '对方户名',
  `account` varchar(100) NOT NULL COMMENT '对方账号',
  `open_account_institutions` varchar(50) NOT NULL COMMENT '对方开户机构',
  `bank_record_time` datetime NOT NULL COMMENT '记账日期',
  `abstracts` varchar(200) NOT NULL COMMENT '摘要',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `serial_number` varchar(100) NOT NULL COMMENT '账户明细编号-交易流水号',
  `voucher_species` varchar(50) NOT NULL COMMENT '凭证种类',
  `voucher_code` varchar(100) NOT NULL COMMENT '凭证号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收付款信息导入表';

-- 返点详情表
CREATE TABLE `rebates_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `type` int(11) NOT NULL COMMENT '客户0|供应商1',
  `start_time` datetime NOT NULL COMMENT '返点开始日期',
  `end_time` datetime NOT NULL COMMENT '返点结束日期',
  `rebates` decimal(10,2) NOT NULL COMMENT '返点',
  `contract_id` int(11) NOT NULL COMMENT '合同编号',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(50) NOT NULL COMMENT '操作人名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收付款信息导入表';
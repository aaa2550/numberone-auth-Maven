
-- 客户公司信息表
DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `companyName` varchar(100) NOT NULL COMMENT '公司全称',
  `customerType` int(11) NOT NULL COMMENT '类型',
  `name` varchar(100) NOT NULL COMMENT '公司简称',
  `province` varchar(20) NOT NULL COMMENT '省份',
  `provinceName` varchar(20) NOT NULL COMMENT '省份',
  `city` varchar(20) NOT NULL COMMENT '城市',
  `cityName` varchar(20) NOT NULL COMMENT '城市',
  `address` varchar(100) COMMENT '地址',
  `linkmanName` varchar(50) NOT NULL COMMENT '联系人姓名',
  `linkmanTel` varchar(50) NOT NULL COMMENT '联系人电话',
  `email` varchar(100) COMMENT '邮箱',
  `remark` varchar(500) COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司信息表';

-- 供应商公司信息表
DROP TABLE IF EXISTS `provider_info`;
CREATE TABLE `provider_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `companyName` varchar(100) NOT NULL COMMENT '公司全称',
  `name` varchar(100) NOT NULL COMMENT '公司简称',
  `province` varchar(20) NOT NULL COMMENT '省份',
  `provinceName` varchar(20) NOT NULL COMMENT '省份',
  `city` varchar(20) NOT NULL COMMENT '城市',
  `address` varchar(100) COMMENT '地址',
  `linkmanName` varchar(50) NOT NULL COMMENT '联系人姓名',
  `linkmanTel` varchar(50) NOT NULL COMMENT '联系人电话',
  `email` varchar(100)  COMMENT '邮箱',
  `remark` varchar(500) COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商公司信息表';

-- 客户发票表
DROP TABLE IF EXISTS `customer_invoice_info`;
CREATE TABLE `customer_invoice_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `companyId` int(11) NOT NULL COMMENT '所属公司',
  `companyName` varchar(250) NOT NULL COMMENT '所属公司名称',
  `taxpayerCode` varchar(100) NOT NULL COMMENT '纳税人识别号',
  `title` varchar(20) NOT NULL COMMENT '收票公司',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `tel` varchar(100) NOT NULL COMMENT '电话',
  `openAccountBank` varchar(100) NOT NULL COMMENT '开户银行',
  `accountCode` varchar(100) NOT NULL COMMENT '银行账户号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户发票表';

-- 供应商发票表
DROP TABLE IF EXISTS `provider_invoice_info`;
CREATE TABLE `provider_invoice_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `companyId` int(11) NOT NULL COMMENT '所属公司',
  `companyName` varchar(250) NOT NULL COMMENT '所属公司名称',
  `taxpayerCode` varchar(100) NOT NULL COMMENT '纳税人识别号',
  `title` varchar(20) NOT NULL COMMENT '收票公司',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `tel` varchar(100) NOT NULL COMMENT '电话',
  `openAccountBank` varchar(100) NOT NULL COMMENT '开户银行',
  `accountCode` varchar(100) NOT NULL COMMENT '银行账户号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商发票表';

-- 银行账户信息
DROP TABLE IF EXISTS `bank_account_info`;
CREATE TABLE `bank_account_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `companyId` int(11) NOT NULL COMMENT '所属公司',
  `companyName` int(11) NOT NULL COMMENT '公司名称',
  `type` int(11) NOT NULL COMMENT '我司1/客户2/供应商3',
  `accountName` varchar(100) NOT NULL COMMENT '账户名称',
  `bankName` varchar(100) NOT NULL COMMENT '银行名称',
  `accountCode` varchar(100) NOT NULL COMMENT '账户号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行账户信息';

-- 客户合同信息表
DROP TABLE IF EXISTS `customer_contract_info`;
CREATE TABLE `customer_contract_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `customerType` int(11) NOT NULL COMMENT '直客0/子客1',
  `businessType` int(11) NOT NULL COMMENT '业务类型',
  `businessTypeName` varchar(100) NOT NULL COMMENT '业务类型名称',
  `contractCode` varchar(100) NOT NULL COMMENT '合同编号',
  `statisticsShortName` varchar(10) NOT NULL COMMENT '统计简称',
  `ourCompanyName` varchar(50) NOT NULL COMMENT '我方主体名称',
  `contractStartTime` datetime NOT NULL COMMENT '合同开始时间',
  `contractEndTime` datetime NOT NULL COMMENT '合同结束时间',
  `rebates` decimal(10,2) NOT NULL COMMENT '返点',
  `orderfrom` int(11) NOT NULL COMMENT '账期（天）',
  `remark` varchar(500) COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户合同信息表';

-- 供应商合同信息表
DROP TABLE IF EXISTS `provider_contract_info`;
CREATE TABLE `provider_contract_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `customerType` int(11) NOT NULL COMMENT '直客0/子客1',
  `businessType` int(11) NOT NULL COMMENT '业务类型',
  `businessTypeName` varchar(50) NOT NULL COMMENT '类型名称',
  `contractCode` varchar(100) NOT NULL COMMENT '合同编号',
  `statisticsShortName` varchar(10) NOT NULL COMMENT '统计简称',
  `ourCompanyName` varchar(50) NOT NULL COMMENT '我方主体名称',
  `contractStartTime` datetime NOT NULL COMMENT '合同开始时间',
  `contractEndTime` datetime NOT NULL COMMENT '合同结束时间',
  `rebates` decimal(10,2) NOT NULL COMMENT '返点',
  `orderfrom` int(11) NOT NULL COMMENT '账期（天）',
  `remark` varchar(500) COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商合同信息表';

-- 点我账户表
DROP TABLE IF EXISTS `keepme_account_info`;
CREATE TABLE `keepme_account_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `appId` varchar(50) NOT NULL COMMENT 'APPID',
  `platform` int(11) NOT NULL COMMENT '投放平台',
  `platformName` varchar(50) NOT NULL COMMENT '投放平台名称',
  `keepmeAccountName` varchar(50) NOT NULL COMMENT '账户名称',
  `keepmeAccounId` varchar(100) NOT NULL COMMENT '账户ID',
  `providerId` int(11) NOT NULL COMMENT '供应商ID',
  `providerName` varchar(20) NOT NULL COMMENT '供应商名称',
  `qq` varchar(20) NOT NULL COMMENT '绑定QQ',
  `industry` varchar(20) NOT NULL COMMENT '行业',
  `generalizeLink` varchar(300) NOT NULL COMMENT '推广链接',
  `services` varchar(50) NOT NULL COMMENT '功能类型 feed/分包/oCPA/DMP/联盟屏蔽/oCP留存/oCP订单',
  `passStatus` int(11) NOT NULL COMMENT '审核状态 未审核 已通过 未通过',
  `passTime` datetime DEFAULT NULL COMMENT '通过时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推广账户表';

-- 充值信息表
DROP TABLE IF EXISTS `recharge_info`;
CREATE TABLE `recharge_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `generalizeId` int(11) NOT NULL COMMENT '推广账户ID',
  `appId` varchar(50) NOT NULL COMMENT 'APPID',
  `customerId` int(11) NOT NULL COMMENT '客户ID',
  `customerName` varchar(150) NOT NULL COMMENT '客户名称',
  `providerId` int(11) NOT NULL COMMENT '供应商ID',
  `providerName` varchar(150) NOT NULL COMMENT '供应商名称',
  `ourRebates` decimal(10,2) NOT NULL COMMENT '我方返点',
  `customerRebates` decimal(10,2) NOT NULL COMMENT '客户返点',
  `accountRecharge` decimal(10,2) NOT NULL COMMENT '账户充值',
  `rebatesRecharge` decimal(10,2) NOT NULL COMMENT '返点充值',
  `rechargeCost` decimal(10,2) NOT NULL COMMENT '充值成本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值信息表';

-- 销售发票记录表
DROP TABLE IF EXISTS `customer_invoice_record`;
CREATE TABLE `customer_invoice_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `invoiceInfoId`  int(11) NOT NULL COMMENT '发票信息表ID',
  `applyName` varchar(50) NOT NULL COMMENT '申请人姓名',
  `customerId` int(11) NOT NULL COMMENT '被开票公司ID',
  `customerName` varchar(150) NOT NULL COMMENT '被开票公司名称',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `platform` varchar(50) NOT NULL COMMENT '投放平台',
  `payTime` datetime NOT NULL COMMENT '费用发生日期',
  `invoiceCode` varchar(50) NOT NULL COMMENT '发票号',
  `openTime` datetime NOT NULL COMMENT '开票日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售发票记录表';

-- 供应商发票记录表
DROP TABLE IF EXISTS `provider_invoice_record`;
CREATE TABLE `provider_invoice_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `invoiceInfoId`  int(11) NOT NULL COMMENT '发票信息表ID',
  `applyName` varchar(50) NOT NULL COMMENT '申请人姓名',
  `customerId` int(11) NOT NULL COMMENT '被开票公司ID',
  `customerName` varchar(150) NOT NULL COMMENT '被开票公司名称',
  `money` decimal(10,2) NOT NULL COMMENT '金额',
  `platform` varchar(50) NOT NULL COMMENT '投放平台',
  `payTime` datetime NOT NULL COMMENT '费用发生日期',
  `invoiceCode` varchar(50) NOT NULL COMMENT '发票号',
  `openTime` datetime NOT NULL COMMENT '开票日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商发票记录表';

-- 收付款信息导入表
DROP TABLE IF EXISTS `return_pay_info`;
CREATE TABLE `return_pay_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `customerId` int(11) NOT NULL COMMENT '统计单位ID',
  `customerName` varchar(200) NOT NULL COMMENT '统计单位名称',
  `transactTime` datetime NOT NULL COMMENT '交易时间',
  `payMoney` decimal(10,2) DEFAULT 0 COMMENT '支出',
  `returnMoney` decimal(10,2) DEFAULT 0 COMMENT '收入',
  `surplusMoney` decimal(10,2) NOT NULL COMMENT '余额',
  `currency` varchar(50) NOT NULL COMMENT '币种',
  `accountName` varchar(100)NOT NULL COMMENT '对方户名',
  `account` varchar(100) NOT NULL COMMENT '对方账号',
  `openAccountInstitutions` varchar(50) NOT NULL COMMENT '对方开户机构',
  `bankRecordTime` datetime NOT NULL COMMENT '记账日期',
  `abstracts` varchar(200) NOT NULL COMMENT '摘要',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `serialNumber` varchar(100) NOT NULL COMMENT '账户明细编号-交易流水号',
  `voucherSpecies` varchar(50) NOT NULL COMMENT '凭证种类',
  `voucherCode` varchar(100) NOT NULL COMMENT '凭证号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收付款信息导入表';

-- 客户返点详情表
DROP TABLE IF EXISTS `customer_rebates_info`;
CREATE TABLE `customer_rebates_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `startTime` datetime NOT NULL COMMENT '返点开始日期',
  `endTime` datetime NOT NULL COMMENT '返点结束日期',
  `rebates` decimal(10,2) NOT NULL COMMENT '返点',
  `contractId` int(11) NOT NULL COMMENT '合同编号',
  `userId` int(11) NOT NULL COMMENT '操作人ID',
  `userName` varchar(50) NOT NULL COMMENT '操作人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户返点详情表';

-- 供应商返点详情表
DROP TABLE IF EXISTS `provider_rebates_info`;
CREATE TABLE `provider_rebates_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  `startTime` datetime NOT NULL COMMENT '返点开始日期',
  `endTime` datetime NOT NULL COMMENT '返点结束日期',
  `rebates` decimal(10,2) NOT NULL COMMENT '返点',
  `contractId` int(11) NOT NULL COMMENT '合同编号',
  `userId` int(11) NOT NULL COMMENT '操作人ID',
  `userName` varchar(50) NOT NULL COMMENT '操作人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商返点详情表';

-- 业务类型表
DROP TABLE IF EXISTS `business_type`;
CREATE TABLE `business_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '业务类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务类型表';

-- 客户收款明细
DROP TABLE IF EXISTS `customer_account_detail`;
CREATE TABLE `customer_account_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businessType` int(11) NOT NULL COMMENT '1业务类型2投放平台3功能类型',
  `businessName` varchar(100) NOT NULL COMMENT '业务名称',
  `businessTypeIndex` int(11) NOT NULL COMMENT '业务对应索引',
  `businessTypeName` varchar(100) NOT NULL COMMENT '业务类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务类型表';

-- 字典表
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businessType` int(11) NOT NULL COMMENT '1业务类型2投放平台3功能类型',
  `businessName` varchar(100) NOT NULL COMMENT '业务名称',
  `businessTypeIndex` int(11) NOT NULL COMMENT '业务对应索引',
  `businessTypeName` varchar(100) NOT NULL COMMENT '业务类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务类型表';
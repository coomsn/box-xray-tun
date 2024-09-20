## 配置文件
#### 路径：`/box_tun/confs/`
#### 自动备份/box_tun/，自动还原/box_tun/confs/、/box_tun/scripts/settings.ini
#### 规则订阅脚本/box_tun/confs/srs，本地规则存储路径/box_tun/confs/rules
#### 规则模板/box_tun/confs/rules/rules_template.json
#### 本版本需要手动调整配置文件，如*.json settings.ini
#### 不支持白名单
#### 黑名单格式如下

```
"exclude_package": [
        "com.ss.android.ugc.aweme",
        "com.cebbank.mobile.cemb",
        "com.sankuai.meituan",
        "com.eg.android.AlipayGphone",
        "com.ss.android.article.lite",
        "com.tencent.mm",
        "com.tencent.mobileqq",
        "com.netease.l10",
        "com.heytap.music",
        "com.finshell.wallet",
        "cmb.pb",
        "com.MobileTicket",
        "tv.danmaku.bili",
        "com.baidu.baidutranslate",
        "com.taobao.taobao",
        "com.baidu.homework",
        "com.ss.android.article.video",
        "com.jingdong.app.mall",
        "com.sankuai.meituan.takeoutnew",
        "com.autonavi.minimap"
      ]
```
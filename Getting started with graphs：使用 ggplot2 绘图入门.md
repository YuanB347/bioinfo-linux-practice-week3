
---

## 1. 本章内容概览

本章主要介绍如何使用 **`ggplot2`** 包创建图形，重点包括：

- 使用 `ggplot()` 构建图形对象
- 使用 `geom_point()` 绘制散点图
- 使用 `geom_smooth()` 添加拟合线
- 设置颜色、点形状、线型、透明度、大小等美化参数
- 自定义坐标轴刻度与标签
- 使用 `facet_wrap()` 进行分面绘图
- 使用 `labs()` 添加标题、副标题、坐标轴标签、图例标题
- 理解 `aes()` 映射放在不同位置的区别
- 将 ggplot 图形保存为对象并继续修改

数据集为 `mosaicData` 包中的 **`CPS85`** 数据集。

---

## 2. 准备工作

### 2.1 加载所需包

```r
library(ggplot2)
library(mosaicData)
```

如果没有安装，可以先运行：

```r
install.packages(c("ggplot2", "mosaicData"))
```

### 2.2 载入数据

```r
data(CPS85)
```

`CPS85` 数据集与 1985 年美国当前人口调查有关，包含工人的工资、工作经验、性别、职业部门等信息。

---

## 3. 使用 ggplot2 创建基本图形

---

### 3.1 建立绘图框架

```r
ggplot(data = CPS85, mapping = aes(x = exper, y = wage))
```

#### 解释
- `ggplot()` 用于创建一个图形对象
- `data = CPS85` 指定使用的数据集
- `aes(x = exper, y = wage)` 指定映射关系：
  - 横轴：`exper`（工作经验）
  - 纵轴：`wage`（工资）

这一步只是定义了图形框架，并不会真正画出点或线。

---

### 3.2 绘制散点图

```r
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point()
```

#### 解释
- `geom_point()` 用于绘制散点图
- 每个观测值会表现为图中的一个点

该图展示了工人工作经验与工资之间的关系。

---

## 4. 数据预处理：去除异常值

```r
CPS85 <- CPS85[CPS85$wage < 40, ]
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point()
```

#### 解释
- 代码保留了 `wage < 40` 的记录
- 目的是去除工资异常高的离群值，使图形更清晰

#### 知识点
在作图前，可以先对数据进行简单清洗，否则极端值可能影响图形展示效果。

---

## 5. 美化散点图

```r
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  theme_bw()
```

#### 参数说明
- `color = "cornflowerblue"`：设置点的颜色
- `alpha = .7`：设置透明度，范围通常为 0 到 1
- `size = 1.5`：设置点的大小
- `theme_bw()`：使用黑白主题，使图形更简洁

#### 总结
通过调整点的颜色、透明度和大小，可以让图形更美观，也能减轻点重叠带来的视觉问题。

---

## 6. 添加线性拟合线

```r
ggplot(data = CPS85, 
       mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  theme_bw() +
  geom_smooth(method = "lm")
```

#### 解释
- `geom_smooth()` 用于添加平滑曲线或拟合线
- `method = "lm"` 表示使用线性回归模型（linear model）

#### 结果含义
图中除了散点外，还增加了一条趋势线，用于展示工资与工作经验之间的大致线性关系。

---

## 7. 按性别区分点和拟合线

```r
ggplot(data = CPS85, 
       mapping = aes(x = exper, y = wage,
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  theme_bw()
```

#### 解释
这里把 `sex` 映射到多个图形属性：

- `color = sex`：不同性别显示不同颜色
- `shape = sex`：不同性别显示不同点形状
- `linetype = sex`：不同性别显示不同线型

#### 另外
- `se = FALSE`：不显示置信区间阴影
- `size = 1.5`：设置拟合线宽度

#### 知识点
把分类变量映射到颜色、形状、线型，是区分不同组别最常见的方式。

---

## 8. 自定义坐标轴与颜色

```r
ggplot(data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5)) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  theme_bw()
```

#### 解释
- `scale_x_continuous()`：设置 x 轴刻度
- `breaks = seq(0, 60, 10)`：x 轴每 10 个单位显示一个刻度
- `scale_y_continuous()`：设置 y 轴刻度
- `breaks = seq(0, 30, 5)`：y 轴每 5 个单位显示一个刻度
- `scale_color_manual()`：手动指定颜色映射

#### 知识点
使用 `scale_*()` 系列函数可以精细控制坐标轴、颜色、标签等内容。

---

## 9. 将工资标签显示为美元格式

```r
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  theme_bw()
```

#### 解释
- `label = scales::dollar`：将 y 轴刻度格式化为美元形式

例如：
- 5 会显示为 `$5`
- 10 会显示为 `$10`

#### 知识点
`scales` 包中的格式化函数常用于改善坐标轴标签显示效果。

---

## 10. 分面绘图：按职业部门分别展示

```r
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~sector) +
  theme_bw()
```

#### 解释
- `facet_wrap(~sector)`：按 `sector` 变量的不同取值生成多个子图
- 每个子图对应一个职业部门

#### 知识点
分面图适合比较不同类别中变量关系的差异。

---

## 11. 添加标题与标签

```r
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3","cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender", shape = "Gender", linetype = "Gender") +
  theme_bw()
```

#### `labs()` 的作用
用于设置：

- 主标题 `title`
- 副标题 `subtitle`
- 图注 `caption`
- x 轴标签 `x`
- y 轴标签 `y`
- 图例标题 `color`、`shape`、`linetype`

#### 知识点
合理的标题和标签可以显著提高图形的可读性与专业性。

---

## 12. 更换主题风格

```r
ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage, color = sex, shape=sex,
                     linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender", shape="Gender", linetype="Gender") +
  theme_minimal()
```

#### 解释
- `theme_minimal()`：使用极简主题风格
- 与 `theme_bw()` 相比，看起来更现代、更简洁

#### 常见主题
- `theme_bw()`
- `theme_minimal()`
- `theme_classic()`
- `theme_gray()`

---

## 13. aes() 放在不同位置的区别

这是本章一个非常重要的知识点。

---

### 13.1 在 `ggplot()` 中设置映射

```r
ggplot(CPS85,
       mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1)
```

#### 解释
因为 `color = sex` 写在 `ggplot()` 中，所以这个映射会被后面的所有几何对象继承：

- 散点按性别着色
- 拟合线也按性别分别绘制

#### 结果
会出现：
- 男性一组点和一条拟合线
- 女性一组点和一条拟合线

---

### 13.2 在 `geom_point()` 中设置映射

```r
ggplot(CPS85, aes(x = exper, y = wage)) +
  geom_point(aes(color = sex), alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1)
```

#### 解释
这里 `color = sex` 只写在 `geom_point()` 中，所以：

- 散点按性别着色
- 拟合线没有按性别区分，只画一条总的线

#### 核心区别
- 写在 `ggplot()` 中：全局映射
- 写在某个 `geom_*()` 中：局部映射

---

## 14. 将 ggplot 图形保存为对象

```r
myplot <- ggplot(data = CPS85, aes(x = exper, y = wage)) +
  geom_point()

myplot
```

#### 解释
- 这里把图形对象赋值给 `myplot`
- 输入 `myplot` 就会显示该图

---

### 14.1 在原有图形基础上继续修改

```r
myplot2 <- myplot + geom_point(size = 3, color = "blue")
myplot2
```

#### 解释
- 在 `myplot` 基础上增加了一个新的图层
- 这个新图层中的点更大，颜色为蓝色

---

### 14.2 在对象基础上继续添加拟合线和标题

```r
myplot + geom_smooth(method = "lm") +
  labs(title = "Mildly interesting graph")
```

#### 知识点
ggplot2 的一个重要特点是：  
**图形可以像对象一样保存和逐步叠加修改。**

这使得图形构建更灵活，也更符合“分层作图”的思想。

---

## 15. 映射与固定属性的区别

```r
ggplot(CPS85, aes(x = exper, y = wage, color = "blue")) +
  geom_point()
```

#### 解释
这里的 `color = "blue"` 写在 `aes()` 中，表示把字符串 `"blue"` 当成一个映射值，而不是直接设置颜色。

这通常不是我们真正想要的写法。

---

### 正确写法

```r
ggplot(CPS85, aes(x = exper, y = wage)) +
  geom_point(color = "blue")
```

#### 区别总结
- 写在 `aes()` 里：表示**映射**
- 写在 `aes()` 外：表示**固定设置**

---

## 16. 本章核心知识总结

---

### 16.1 ggplot2 基本结构

```r
ggplot(data = 数据框, mapping = aes(...)) +
  几何对象 +
  坐标轴设置 +
  分面 +
  标签 +
  主题
```

---

### 16.2 常用几何对象

- `geom_point()`：散点图
- `geom_smooth()`：平滑线/拟合线

---

### 16.3 常用图形属性

- `color`：颜色
- `shape`：点形状
- `linetype`：线型
- `size`：大小
- `alpha`：透明度

---

### 16.4 常用辅助函数

- `scale_x_continuous()`：设置 x 轴
- `scale_y_continuous()`：设置 y 轴
- `scale_color_manual()`：手动设置颜色
- `facet_wrap()`：分面
- `labs()`：添加标题和标签
- `theme_bw()` / `theme_minimal()`：设置主题

---

### 16.5 重要思想

#### （1）图层思想
ggplot2 图形是通过 `+` 逐层叠加形成的。

#### （2）映射与设置的区别
- `aes()` 内：变量映射
- `aes()` 外：固定属性

#### （3）全局映射与局部映射
- 放在 `ggplot()` 中：全局生效
- 放在某个 `geom_*()` 中：只对该图层生效

---

## 17. 学习体会与理解

通过本章可以看出，`ggplot2` 的绘图方式与基础绘图系统不同，它强调：

- 先定义数据和映射关系
- 再逐层添加图形元素
- 最后进行美化和布局调整

这种方法的优点是：

- 结构清晰
- 代码可读性强
- 便于扩展与修改
- 适合绘制复杂图形

对于初学者来说，最重要的是先理解以下三个问题：

1. **数据来自哪里？**
2. **哪个变量映射到哪个图形属性？**
3. **哪些内容是映射，哪些内容是固定设置？**

只要把这三个问题想清楚，ggplot2 就会变得很好理解。

---

## 18. 可直接复习的简要总结

- `ggplot()`：创建图形框架
- `aes()`：设置映射关系
- `geom_point()`：画散点图
- `geom_smooth(method = "lm")`：添加线性拟合线
- `facet_wrap(~变量)`：按类别分面
- `labs()`：添加标题和标签
- `theme_*()`：修改图形风格
- `scale_*()`：修改刻度和颜色
- `aes()` 中是映射，外面是固定属性
- `ggplot()` 中映射是全局的，`geom_*()` 中映射是局部的

---

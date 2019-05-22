# react编译启用sourceMap


正式环境如果出现错误,白屏,然后哪行报错也看不出来,排除问题麻烦至极

```js
export default {
    treeShaking: true,
    devtool: 'source-map',//加上这句即可
    plugins: [
        ['umi-plugin-react', {
            singular: true,
        }],
    ],
};

```

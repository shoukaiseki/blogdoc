# react编译启用sourceMap

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

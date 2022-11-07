# :earth_asia: UN PET Lab Competition 2022 :see_no_evil::hear_no_evil::speak_no_evil: :earth_africa:

Welcome to the main repository of the UN PET Lab's 2022 data science competition. In this competition, you will get to learn about modern privacy-enhancing technologies, secure enclaves, differential privacy, the privacy-utility tradeoff, eyes-off-data-science, and more. You will then apply your new-found knowledge to learn about a real UN dataset which must be kept semi-private.

**Sign-up now if you haven't already (will close registrations on the 7th of November):** https://petlab.officialstatistics.org/

---

:book: What's in the repository:
1. [What's the competition all about? :thinking:](#intro)
2. [Why are the UN & the NSOs interested? :united_nations:](#why-pets)
3. [How does the competition work? :computer:](#how-to)
4. [How do I learn about the frameworks used in the competition? :brain: ](#learn)
5. [How does scoring work? :100:](#score)
6. [Where do I find the starter code? :baby:](#starter)
7. [Where can I watch back the webinars? :tv:](#playback)
8. [Credits & Acknowledgements :film_projector:](#creds)

---

<a name="intro"/>

## 1. What's the competition all about? :thinking:

The competition is just like most other data science competitions, like Kaggle, DrivenData, or any of the others you may be familiar with, but with one major difference. You do not have direct access to all of your training data.

The dataset of the competition is split into columns and rows of data. The vast majority of columns are seen by the competitors. (`x` and `y`) Rows are also split between those used for training and testing (`train` and `test`).  At the beginning of the competition, you will be sharing `train_x` and `test_x` and your goal will be to predict `test_y`.

So how can you go about predicting `test_y`?

Good question. You could simply guess it purely at random, but depending on the weighting of the labels in `train_y` you will have a very hard time getting any meaningful score.

Really what you would like to do is to ask questions about the relationship between `train_x` and `train_y` and hence endeavor to learn the function `f` which minimizes

```math
|f(train\_x) - train\_y|
```

assuming this also minimizes

```math
|f(test\_x) - test\_y| 
```

This is where enclaves and differential privacy enters the mix. You can ask questions using OpenDP (to take transformations and measurements), SmartNoise (to make noisy SQL queries and synthetic data) and DiffPrivLib (to train noisy machine learning models). Each query will cost you some epsilon and depending on the query, delta. The more of this you spend, the more your score will be decreased, but hopefully, you’ve learned something of value and thus your submissions are more accurate and thus your overall score improves.

Trading off privacy versus accuracy (also known as utility) is a very important and “hot” topic within the privacy-enhancing technologies domain.  In this competition, you’ll be trying your best to balance these too.

<a name="why-pets"/>

## 2. Why are the UN & the NSOs interested? :united_nations:

Data disclosure controls are of utmost importance to national statistics offices (NSOs), governments, and NGOs. Such controls have been used in one form or another to protect the identity and anonymity of citizens in surveys for over a century. 

However, typical data disclosure controls lack some of the mathematical guarantees which can be offered by model privacy-enhancing technologies such as Differential Privacy. They also tend to be highly manual processes, which minimizes their ability to be automated. 

Enclaves, and input privacy in general, are also an important part of the picture. NSOs are constantly limited in terms of the data they can collect, join and disseminate, undergoing strict privacy impact assessments to make sure the data they maintain is used for its intended purpose. 

Many micro data libraries from NSOs and, for example, the UN, require users to say via a form the intended usage of the data as light control. However,  there are no guarantees when using a good-faith system like this. Enclaves guarantee the software that will be run on the sensitive data, hence giving a much stricter level of control.

When combining data from multiple sources, for example, healthcare and census information, the combined dataset is often more sensitive than either one individually. Traditionally in many NSOs, a member of staff would have to take an oath and pledge to only use the data in a very limited capacity and never disclose any of it to another person. This of course ends up being very bureaucratic and blindly trusts individuals. Enclaves allow technology hardware and cloud providers to act as data brokers automatically. While in theory, you are still entrusting chip manufacturers and cloud providers, there are many advantages such as the ability to perform rigorous security and compliance audits and reviews. Hence mitigating much of the risk.

This competition endeavors to simulate a very realistic scenario for early adopters of PETs amongst NSOs in which they wish to allow users to perform eyes-off data science for the public good; minimizing data leakage risk while providing the ability to make data-driven decision-making. How well you all do, what strategies appeared to be the most effective, and ultimately your direct feedback (which we’ll ask via a short survey at the end) is extremely informative to the NSOs.

<a name="how-to"/>

## 3. How does the competition work? :computer:

As discussed in **[1. What’s the competition all about?](#/intro)**, this is primarily a data-science competition - just one where you are limited to the tools of enclaves and differential privacy.

We have set you up with three subdirectories in this repo. The first, named `proxies`, shows you how to install and make a proxy connection to the enclave. It should only be used if you wish to run everything locally. This is strongly not advised as due to the number of contestants our ability to support you if you have an issue with Python versions, pip, Jupiter, proxying,  etc will be extremely limited.

Instead,  you’ll find links below that will open a [Datalore](https://datalore.jetbrains.com/) (JetBrains version of Google Colab) with Jupiter Notebooks ready to go. You may be wondering why we are sharing these via Datalore and not the more popular Google Colab, and the honest answer is that the library dependencies need at minimum Python3.8 and Google Colab is still at Python3.7. There are hacks around this, but we thought it would cause more confusion than it was worth.

The second folder, named `sandbox` offers Jupyter Notebooks (via Datalore) with worked solutions you can play with. The sandbox just uses a standard UCI dataset and your scores etc have no impact on the competition. Consider it a training ground.

Finally, there is `competition` which is similar to `sandbox` but only offers basic scaffolding for you to use in the actual competition. What you do in there **will** affect your score, so thread lightly!

Finally, to connect to the enclaves, you’ll need a public/private key pair which will authenticate you and your team (one key pair per member of the team - don’t share as you may kick one another off their session depending on internal routing in the enclave cluster).

<a name="learn"/>

## 4. How do I learn about the frameworks used in the competition? :brain: 

It’s pretty straightforward - you just learn the underlying tools directly. From the enclave perspective, you’ll be guided through it in the notebooks themselves, so that part would be self-explanatory. For the differential privacy libraries check out the following:
1. [OpenDP](https://github.com/opendp/opendp)
2. [SmartNoise SQL](https://github.com/opendp/smartnoise-sdk/tree/main/sql)
3. [SmartNoise Synth](https://github.com/opendp/smartnoise-sdk/tree/main/synth)
4. [DiffPrivLib](https://github.com/IBM/differential-privacy-library)

<a name="score"/>

## 5. How does scoring work? :100:

The scoring, as presented in workshop 2 (at XX:YY:ZZ), is determined as your accuracy less a function of the privacy used to get you there. More precisely, your score equals to:

```math
Score = Accuracy - \frac{\epsilon}{\sigma} -  \left(1 - \exp(-\alpha \delta D)\right)^\beta
```

Where Accuracy is simply your accuracy at predicting `test_y` , $\epsilon$ and $delta$ are the privacy parameters from differential privacy, $D$ is the dataset size, and $\sigma$, $\alpha$ and $\beta$ are all constants set to 100, 5 and 3 respectively. 

<a name="starter"/>

## 6. Where do I find starter code? :baby:

Starter code is in the subfolders `/sandbox` and `/competition` respectively. Equally quick start by going straight to the Datalore Notebooks:
- [Click to go to the sandbox](https://datalore.jetbrains.com/notebook/NXWf3mP22kJx8uvDGNLauL/d3m9EoiEF4v4UEchpwc0wp/)
- Click to go to the competition (Coming soon: 2pm Indonesia Time, Nov 8th of September)

**A note on Datalore**: Datalore is a paid product by JetBrains, which we have no affinity with whatsoever. However, you get 72 hours for free per month of Jupiter Notebook time, running Python3.8. It appeared to give the exact time of the competition for free and the right dependencies, so we thought using it as the code template tool made sense (to be clear, this is not an endorsement nor is it an encouragement to use the paid tier ever and you certainly don’t need to provide them with payment information).

<a name="playback"/>

## 7. Where can I watch back the webinars? :tv:

Click on the thumbnails below to begin playback:

**Webinar 1: An Introduction to Privacy Enhancing Technologies & the first UN PET Lab Hackathon**  

[![Preview and link to webinar 1](https://img.youtube.com/vi/Zrr_TPXMntU/maxresdefault.jpg)](https://www.youtube.com/watch?v=Zrr_TPXMntU)

**Webinar 2: Getting Hands-On with the Tools and Frameworks of the UN PET Lab Hackathon**

*[![Preview and link to webinar 2](https://img.youtube.com/vi/BDYjZUCEUog/maxresdefault.jpg)](https://www.youtube.com/watch?v=BDYjZUCEUog)

<a name="creds"/>

## 8. Credits & Acknowledgements :film_projector:

**Development of user tools, APIs, proxies, and enclaves:**

![](https://oblv.io/badge)

**Differential privacy frameworks from:**

![](https://img.shields.io/badge/-OpenDP_/_SmartNoise-blue?style=for-the-badge&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAACMAAAAjCAYAAAAe2bNZAAAHlklEQVR42p1YA7CkzQ69Wtu2bdu2bdu2bdu2bdu2bQ7yclI3r1Lfr91N1ZnP6dNRp8fn34SIfBl%2B9l7Dhg1bNWrUaM2bN29mEtF%2BxhXGecYlxknGCkZ7RkFGeKPLD%2Fp8%2FkQMCZyH%2FvnzZ3sMvnnz5s%2B49fLlS%2FoFucAYyohrdPn%2FLhF%2Fc16bcVu1P3v2jNauXev5%2FPmzm4g8DC8Exy9fvninTJni2bdvn4tv4bnKG0Y%2FRrjfIkREAYHHqIyVRiEGdmHQBw8eCClwUEAeP35MESNGJLYeQQIJASpwZc5fIaQv4JiWcZ0BEQtgQI%2FHQ5CRI0dSly5d6OvXrwRRMuxKunLlCr17944cghcwEch3RgUz8X8lkonxlAFx2cGUzJIlS6h69er0%2Fv17JSNg1wkhvWefGX16LG%2FHdQYrjtE0PliByxKwA7x69Ypu375N9pnL5aJx48bRhg0b8N6%2FEXIbtxezhCR9DakNgR%2F%2F1EHbt29Pp0%2BftspFNm7cSBcvXiSVt2%2FfElQsXrzYWpE%2BfvxIkydPprNnz6oOS%2BgRI5by%2BL9V3G53I2WugyImunfvTunSpaM7d%2B6QCr9LGTJkoKFDh9KPHz8I8vz5c2rVqhVduHCBrMyYMUNInjt3Tsk4XbbUaZ3QjHtqPv1IU7lIkSJUp04dshm0evVqpLgQw7VaAeT0euvWrSCC7HK6G%2FDqJbs4t4%2FK9%2B%2FfO3%2F48IG%2BffvmURMDGAiC2SJgr169SqqMa4qksloGWXT%2F%2Fn18h%2BfQRc2bN6dJkyZp1ukznKo11Tor1SohX7x4cRSpOnHiRJd%2BqAIFCE5UXF4CiN8lyOvXr6lx48ZifhArWbIkBrYWADnJOFsW9NvZs2dT4sSJvVwgpSqwZAaZXGwB7%2B7du71btmzxIjVv3LhBJ0%2BepE%2BfPpF12alTpyhp0qR0%2Fvx5IZY8eXJatGgRXb58mfz8%2FGjv3r1CbMWKFXTr1i1njIglQQpWrFy5MuJJrYP7XUCmvaayumXlypXia8wcA6B%2BQFDMmjZtSunTp6d79%2B7R2LFjqV%2B%2FfogJvC%2BTmDt3rpzDtWqRu3fv0oQJEyhz5sy4D%2FcjU7Umqcn2gsyaQDIenQVmd%2BLECercubMo1kCFPH36lHLlykVDhgyRmVWqVIl69OhBLVq0oOXLl8v7bGEMJO5dsGCB3MuTJw8tW7bMVmen5d6BzFm97%2FQt3HTs2DHCWoRYGTFihAy0Z88eybCyZctKisePH58qVqxIKVOmpGnTptHhw4cl7Q8dOkQ7d%2B4Ukg8fPhRyGocKKyDzUsnQvwisheKVJEkSatCgAVWrVk1mHBAQQP7%2B%2FnKeM2dOyaAsWbJQzZo1JTZ%2BQ7w%2BNmvgR1gBswBwjozA8dGjRxITO3bsoGbNmsngESJEABFBiBAhKGjQoJQpUyaaOXOmZJl%2Bp3pUr%2BqGy%2BFOFR9dgxCkWm3z5csncaHInTs3Zc2aFRCroABGihRJCPn6%2BgpgIVwXKlRIrFOqVCkhliNHDrGY1Zc3b16xXoUKFejmzZsaI%2BImXMGfXqwfmPmuXbsUcg2%2Fc%2BpLLGBNUsuECRMGKS1kQoUKJfeQMXDngQMHaP%2F%2B%2FVaHU6%2FEFIqtJbPDLgPOSLcxA0Jt2rTBzDBzGRyAizRmihYtCiDTdD37ZQGZsXaB1GUAwDlW4%2B3bt1Pp0qVlwMGDB9O2bdvkGkUPAQ3rwJXBggWjWbNmIYVBTN4fNWqUxBovOZic1Y1rmzhXQKaCXUWtoMpWrVpVSUjlRZ1AoUPcDB8%2BXKxQr149atu2raR%2B9OjRpXo%2FefKEVq1aRSVKlMD3SG8hYURTW29OAJkEqNTykAVrEMr5tWvXJKg3bdokJOAmyMKFC6Fclobp06dLv4POD4F66dIlateuHfXq1UuzRDJmzZo1qOTQjx4I7%2BkCa8kU8YEw40VEhMh2RY4cWQY7cuSIM3ak2OEZ2ge4r1atWnALLIH7qNoojij%2FmIhaQl0PPVhM8S6qNr5TImfZC2GFDGdSHrgJDdL69eu98LFWS1WI9kHdhVmht8E1CMKaBQsWpPnz5%2BsqjwCGFTVW1CVwsyQCbwYJdoDVWbo6G%2FF5ztixSpCGvXv3FhIQtKL4DCs2hGsLMk0XVUwKzxHsGqyAbVM9XEpQFK%2FrzlN7YBzjMB6ZzLINNayBJknvIUART1on0IgjhmAJbVnRoGt8qR6F12RRGTWK0zqVjFVgEskCLP%2Fo3JzbFhUdHFZD4Oo7yEZUdbSfSsTsoeDOUc6ttHO70oEBQRB7cAvZooPoaj5v3jy6fv06qeA54ungwYOWNLJQJ2KJQDaqV%2FSo4nRZR1RPPkXf4sbg1hpITTxDHKlgwGLFiuF9bcoFKrovN0RCWyP8ExlxGVfY%2Fkg%2FpDCUsLhwVPNj3XHuKM%2BcOaMdno03xJ%2F16YRf%2FUfCmiwEN1b5ObX3OPbMbm3EVMw%2BCwUSGYUbHkdVv8uo6AyLXxHnTrMBsvufFlF1H%2FricOHCadyoXEUdYYRTvcA%2FDswFKggjpAWnbUhuzEMDeIeX%2FXA842KcupM5WG%2BgsBmAHAqalxt2BPdTfmcxv1%2BPYy8uvuc1KhhvS0KzXjOOnGOcoAz%2F%2FwHhJgAbxX1etQAAAABJRU5ErkJggg%3D%3D)

![](https://img.shields.io/badge/-IBM_RESEARCH-blue?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAMAAAAp4XiDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHmUExURQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQICAgQEBAcHBwgICAsLCwwMDA0NDQ4ODg8PDxAQEBERERISEhMTExQUFBsbGx0dHR4eHh8fHyAgICEhISIiIiMjIykpKS8vLzExMT4+PkNDQ0VFRUZGRkdHR0hISElJSUpKSktLS05OTlBQUFVVVVZWVldXV1lZWVpaWltbW1xcXF5eXl9fX2FhYWVlZWhoaGlpaWpqam1tbW5ubm9vb3FxcXd3d3t7e319fX5+foGBgYKCgoSEhIaGhpCQkJGRkZKSkpOTk5eXl5ycnJ6enqenp6ioqK+vr7CwsLGxsbOzs7S0tLe3t7i4uLm5ub29vb+/v8fHx8vLy9bW1tfX19jY2NnZ2b92gGYAAABJdFJOUwACAwQTFBUWFxgZHyAnKCkvMDhXYmNkZWZ/gIGGh46PlpmanJ2en6ChqKmztLW8vb6/xMXGz9DT1NbX2Nna29zg4e7v8PH7/P1ZnKi9AAACqUlEQVQYGZXBi0NLURwH8J/yStdSGYrkkR5ENpRHFFP2zVa2Tt6roby5rbx3LXSLu4UUeYzUf+rcc480tXb3+dBCBc5t+xo9rd6Wetcup4Myyi9pQorDmxVaSlEtFlFdSOnk7UYalQotqtiDtJo30UK5W7Gkshz6z0o3Mji4ilKsPoaMjqygeZa5YYM7l/4pgy3lNGcjbComSWmGTZ41ZKmEbbtJKEQWishUjSzsIU5BVhQi2oyslBJRA0xBCwKWdnBBUzu4oCkA0wkiB4SpWeHyr1nL5z5g2vQegO/rNPcFgoOcEELdQlvPnPPoEdoA1mO6AsFJFRDGkwL7lvxrAknhIfA6afoAYRu5IN1UVQburqr6EFRVlcGncvfRoXL3INVRPaTRRIKBe5dI+HBhbGyMwR83sWtxbgTScWqBNBCNMnCPX1h6Ab+mvdC0m6r2SNMGIXnIC2lI1xm4V7olBPh1PfZSfzqsD+l6DNIZOgPp5fAwAzf0xnIB8Ot67LrOXdf1GCQveSANahoD90Sz9AH+aHSQaZr2nEWjA5BOUyOkEcNg4N4ahg8XDcNg8Mfjo3hmGL1d8fgIpHraD+l+JNIB7kEkchYsEomcg7+//zbCqnqJ9fffguSi7RA+JIXQZPKvT/4kNwlMfERXkhuHUEFOCFfDAnrmXEKY6wZCXWgLc90Q1lMBhKnfQujntOX7HWCG+wHcYLg8w01BWEvUBFOgU0CnJQCu0wSh0wRTAxGVIislRJSPrCjE1SILVWQqQhYKSaiBbZVkyfPApmaFpGLYtJHmlMOWLfRPrhs2HMiheZYfQUZHV1GKlW5k4F5B/8kpw5LKc2mhDSeRlqeYFqVUIo2aPEpnXRUWsbeIlqKUNCDFiZJ8ysixfqfr0Glv66nGuh1OBy3wB8DsfO1MzOH9AAAAAElFTkSuQmCC)

**Deployed on:**

![](https://img.shields.io/badge/-AWS_NITRO-EEE?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAAAgCAYAAAC/40AfAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH5goXEDoR2Ih4QwAAB21JREFUWMPN2GmsXVUVB/Dfue89akeBKtSClGIfWFvbUkSFMlhjBaEIGgGNFU0woCJqotGEqDgkmjjgGEPV8EEjg+CIhihzK5Sx9EEZW2iLIiKVAoXOvccPa513zz29r5JI0JWc3HP23Wef9V/Df629CxicfYyaTMZbMB/TMQFbsRZ/xq/xr5w7Cu/EJKzDVdi+amhJfc1JOBGjcVehfVOppTHnQLwd/bgaq3J8NBbiPanLqPz23fmta/A8rBpaol+3nIQvYwb2aPz3Bpyc1yfxcM75BI7CYzgeKwdnHV1/7zRcgD4sLbUW4tnG2h/FZ7EN70swE/E1vB9jG/OPwBn4Dr6AtrQEGNhe2D5QnopD8RQeSm9sS+vOxSvSyhtwJjbizgQzOeesVBTVsq38cF8+T8cU3DNtzrGUJYzDvPz/n7hHicJ5OCvHV+HW9Mo4TMtvzUtvbe4Cs6O/hJvxCP6QYJ4raJfxwjz8BAfhBMzEctyIj2EAh+NnNQvujdfVnvfK53uKAAIHpHJwF9YoHIL35tgd+ADlAwwbaSxm5/rb6pZTFnFhMb6UCzwrgBA5cx0uqyk1M++X4295Pxfja8pPyespPJgeOrQRMrPS43ADduQ7E3NsKepAiDy5OY2+sxps5kxp97Iy5xR4ZY49JkJtalr4ANyb/83Ey/GXDJNDMCdDY2vOeWOCfDrnwaYENaoGdn1T0dVDS7qUa8HqFd2DKRNEHkzGnkV7e/WRdsMQO0SoSWvOrK0xN3+Hcs5OHIx9c3wsDsv7+8MD5O99eT8flwgi2S8NqRAsXGfiFrtQ8yx8G3/CkryuK1sDv8KHNPydskyEUp/IGxiTaxG5sBJPpHEGc/zVtfulOiy3Ht8URNPC2/ALXCtS4RTsWX280r8XNX9f8D6RXJsFm80ZAQhBFvcLkjgML8OrUtHnEsjfBStNFsl7LV6PfUTI3dhY84oc/0yuOUaE6SH4IG7CebilLHaEZ2pemYZvJZBN+KFgrfl4qyheF+qEWV025uJEGFXW3xePYk0qNpRzKhI4PL25FitA33A+l/h9GvhkfEMQ0xZR3+anl6YWZb/B2cd0eeaEVES69FNqTFGTM9P1TVkiiuk+ouhOT8/fp9Mx3Jm/M7C/Tr7cin/AquVhk5qRnxGV/hrBosfi/IyUWQn0u3SH2fSaRW4YBlKWakVwP1FP6BTCSlaIluZgUUQPzPHlNaOsFKx1gAjJKl+urzzeyN/m9zfgtyLcL00PVXp3Wbio/Y7ujA4vNC5dXsleHezgcREGcJxof7aL5K9kbV574vT04uO4pWGYTm4WPdN0o064b+4F5sHa/WmCaYr0xKDIpxNrc+ZgbO27beFRIrEPSkUfqr3zdHqnD+8QdWQoAVrVqRsL8nvHCLofSF0HhOc/LkhmR2WIQneYXYVzRfFbIKrrvaKiz05wv0lFp4mea66g1EpuFbRaVfTVCagO+E4sSmWkAbY0iPK1+DTOFg3tXwUrThD5NiXn/TH1VqJVs8YDonNdl0BniQ52oaDFr4s68z3BdktF9a9bdHVaamda7aZ6GKTcIQhhp0j662O4q/m4QRBKfxpyoejVTkggz+NiQTjPVDo068wVol6cmKFVpoLXithv46L02N06LFXJJsGCP0owFRXX9y+3410ib9bnunWDyLVPEXn3poyECeFBqxPssqah+hsfkoreWzVgPWRTx5o95eG8hqXsLk1bdYfmSLJBbNSuzue+NO4uda4yxC767kKNjRdeSqnr0i4L+4/f4upFtxlo9e6Hi3JxY+Dsl1zn3UpTP1E2Joqwa4lIeRIbi3KxSYIyt3RWoPjI/xrGLkBm4N3ifGKqYNlC5M2juKgfnxON5AUiOSk6C/2feGoRPi+K7GaRd5tE4Z4oWiMt/EC0BVcmoBn1Ulou7unql1IKUXjPEX3ZkXkdJSi76jCe7xd7/g+LU5lzcbq2X4pmc0i0JB1ABcVZL0yLF0lK3FZ7Hi8KeFVMV4ou/IE6AewhOuIvirBbL+rL5WI7+0RPs73IYThCFLREe3S86Omm4lTRTVyFo7GoKH+q2egfKQ41FuTzNtG3XSMOAVeII6G2EeSFAix/bHenDgPpgTcniGNFt71ZpMZX0+hLxC73+OE607DIXiL0ztHpgwjGWyNakmUiDNfkYlv9dzJGHJIMin3OESJ89tPZbtwuDgavTBcsws/xFZzfVTR7uHiGOG08VTBJUzaKRnKNaDPWiGOnJwXdb0qQle/7RTiPE+3Mvmn914iW5cAcG934zsOijbpIbuIS4MWi2T0Oj/TsWBqgWmmhM8SubordSzsBVNf2Gpi+BDOqdo10rrBT9ImXiY3Y6h6GvlyE2yV2s9BIiThNdK4npUX29uJKWxx8LMPvxMFjfQuhOHtYt7liq3BpvjcymGFQF/acNSYXmpfXTHGIMd6uJz67k62ioVwniKU6LFwrS0IdxLBOC8T2sd39/38E0wWst7f6RT4dlAAHRShOEqeZo0Wo7hT7kKfS+o8IlnwQ65Q29NKmFzOO1E/+G1rQH4Iguf27AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEwLTIzVDE2OjU4OjE2KzAwOjAwSk9XuAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMC0yM1QxNjo1ODoxNiswMDowMDsS7wQAAAAodEVYdGRhdGU6dGltZXN0YW1wADIwMjItMTAtMjNUMTY6NTg6MTcrMDA6MDDKcMVvAAAAAElFTkSuQmCC)

**Dataset in competition provided by:**

![](https://img.shields.io/badge/-UNHCR-C2D7D0?style=for-the-badge&logo=data:image/png;base64,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)

**A special thanks also to all of the members of the UN PET Lab, the volunteer mentors and, of course, the participants** :pray:

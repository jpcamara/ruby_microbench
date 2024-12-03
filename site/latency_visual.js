// This code is taken from https://benjdd.com/languages/, with permission: https://x.com/BenjDicken/status/1862623583803253149
// The core visual is identical, and the data used is specific to Ruby implementations.

class LatencyVisual {

    constructor(id, timings, minSlow, maxSlow) {
     
      //////////////////////////////////
      //                              //
      // 1,000,000,000ns = 1s         //
      // 1,000,000us = 1s             //
      // 1,000ms = 1s                 //
      //                              //
      // timings below in nanoseconds //
      //                              //
      //////////////////////////////////
     
      this.timings = timings;
  
      for (const timing of timings) {
        timing.class = id + '-' + timing.class;
      }
  
      this.minSlow = minSlow;
      this.maxSlow = maxSlow;
      this.slowdown = this.maxSlow/2;
      this.oneBillion = 1000000000;
      this.oneMillion = 1000000;
      this.totalTime = 1000000;
     
      this.id = id;
      this.dom = document.getElementById(this.id);
      this.initializeBaseElements();
      this.domSVG = this.dom.getElementsByClassName('latencySVG')[0];
      this.domSVG.style.height = this.domSVG.clientWidth/4 + 'px';
      
      this.updateSizes();
      
      window.addEventListener("resize", function(event) {
        this.redrawAfterChange();
      }.bind(this), false);
      
      this.initialize();
     
      setTimeout((() => { 
        for (const t of this.timings) {
          this.animateCircle(`.${t.class}Ball`, this.D, t, t.timeFor);
        }
      }).bind(this), 500);
  
    }
    
    redrawAfterChange() {
      this.updateSizes();
      this.initialize();
      this.update();
    }
  
    initializeBaseElements() {
      const container = d3.select('#' + this.id)
        .append('div')
          .attr('class', 'interactivityContainer')
          .attr('id', 'interactivityContainer')
        .style('width', '100%');
      const svgContainer = container.append('div')
        .attr('class', 'svgContainer')
        .style('margin-left', 'auto')
        .style('margin-right', 'auto')
        .style('width', '100%')
        .style('max-width', '1000px');
      this.svg = svgContainer.append('svg')
        .attr('class', 'latencySVG')
        .attr('id', 'latencySVGID')
        .style('width', '100%')
        .style('height', '100%');
    }
    
    updateSizes() {
  
      this.domSVG.style.height = this.domSVG.clientWidth + 'px';
      this.width = this.domSVG.clientWidth;
      this.height = this.width;
  
      this.cr = this.height / (this.timings.length*2 + 3);
      this.fontSize = this.width / 43;
      this.strokeWidth = this.width * 0.025;
      
      this.X = this.width*0.085;
      this.W = this.width*0.315;
      this.H = this.height / (this.timings.length+2); 
      this.BX = this.width*0.4 + this.cr;
      this.EX = this.width - this.cr - this.strokeWidth/2;
      this.D = this.EX - this.BX;
  
      let spacing = (this.height / (this.timings.length+1))
      let i = 0;
      for (let timing of this.timings) {
        i++;
        timing.y = spacing * i;
        timing.cx = this.BX;
        timing.prevT = 0;
        timing.forward = true;
        timing.begin = this.BX;
        timing.end = this.EX;
      }
    }
  
    drawBox(timing, x, w, h) {
      this.svg.select(`.${timing.class}Ball`)
        .attr('fill', timing.color)
        .attr('cx', this.BX)
        .attr('cy', timing.y)
        .attr('stroke', '#444')
        .attr('stroke-width', 1)
        .style('filter', 'drop-shadow(2px 2px 2px #00000025)')
        .attr('rx', this.cr)
        .attr('ry', this.cr)
      this.svg.select(`.${timing.class}`)
        .attr('fill', '#444')
        .attr('x', x)
        .attr('y', timing.y - (h/2))
        .style('filter', 'drop-shadow(2px 2px 2px #00000025)')
        .attr('width', w)
        .attr('height', h);
      this.svg.select(`.${timing.class}Label`)
        .text(timing.label)
        .style("font-size", this.fontSize + 'px')
        .attr('text-anchor', 'middle')
        .attr('dominant-baseline', 'middle')
        .attr('fill', '#fff')
        .attr('x', x + w/2)
        .attr('y', timing.y + (h*0.05)); 
      this.svg.select(`.${timing.class}Image`)
        .attr('href', timing.image)
        .attr('x', x - (h))
        .attr('y', timing.y - (h/2))
        .style('filter', 'drop-shadow(2px 2px 2px #00000050)')
        .attr('width', h-10)
        .attr('height', h)
      if (timing.change != undefined) {
        this.svg.select(`.${timing.class}Change`)
          .attr('text-anchor', 'middle')
          .attr('dominant-baseline', 'middle')
          .attr('x', x + h*0.4)
          .attr('y', timing.y + h*0.05)
          .attr('fill', (d) => timing.change > 0 ? '#75db8c' : '#ff7082')
          .style('filter', 'drop-shadow(2px 2px 2px #00000050)')
          .attr('width', h)
          .attr('height', h)
          .style('font-size', '20px')
          .style('font-weight', '700')
          .text((d) => (timing.change > 0 ? '+' : '') + timing.change)
      }
    }
    
    initialize() {
      this.svg.selectAll('.IOsPerSecond')
        .data([0])
        .join((enter) => enter.append('g').attr('class', 'IOsPerSecond'));
  
      const background = this.svg.select('.IOsPerSecond').selectAll('.diagram')
        .data([0])
        .join(
          (enter) => {
            let g = enter.append('g').attr('class', 'diagram');
            g.append('rect').attr('class', 'background')
            for (let timing of this.timings) {
              g.append('rect').attr('class', timing.class);
              g.append('text').attr('class', timing.class + 'Label');
              g.append('ellipse').attr('class', timing.class + 'Ball');
              g.append('image').attr('class', timing.class + 'Image');
              g.append('text').attr('class', timing.class + 'Change');
            }
            return g;
          }
        );
      
      background.select('.background')
        .attr('fill', '#eee')
        .attr('stroke', '#444')
        .attr('stroke-width', this.strokeWidth)
        .attr('x', 1)
        .attr('y', 1)
        .attr('width', this.width-2)
        .attr('height', this.height-2);
      
      for (let timing of this.timings) {
        this.drawBox(timing, this.X, this.W, this.H)
      } 
    }
  
    animateCircle(selector, d, stash, tns) {
      let b = this.svg.select(selector);
      b.transition().ease(d3.easeLinear).duration(this.totalTime)
        .attrTween('cx', 
          () => {
            return function(t) {
              const elapsedMS = (t*this.totalTime) - stash.prevT; // 100
              const ioMS = ( (tns * this.slowdown) / this.oneMillion);
              const travelDistTotal = d * (elapsedMS / ioMS);
              let travelDist = travelDistTotal * 2;
  
              if (!stash.forward)
                travelDist = -travelDist;
              stash.cx += travelDist;
  
              if (stash.forward && stash.cx > stash.end) {
                stash.forward = !stash.forward;
                stash.cx -= stash.cx - stash.end;
              } else if (!stash.forward && stash.cx < stash.begin) {
                stash.forward = !stash.forward;
                stash.cx -= stash.cx - stash.begin;
              }
  
              stash.prevT = (t*this.totalTime);
              return stash.cx;
            }.bind(this);
          }
        );
    }
  }
  
  const loops = new LatencyVisual('loops', 
      [
        {
          label: 'Ruby 3.4 (0.40s)', 
          image: './ruby.png',
          timeFor: 400000000,
          class: 'ruby34',
          color: 'rgb(101, 155, 211)'
        },
        {
          label: 'Ruby 3.4 YJIT (0.41s)',
          image: './ruby.png',
          timeFor: 410000000,
          class: 'ruby34yjit',
          color: 'rgb(50, 20, 10)'
        },
        {
          label: 'Ruby 3.3 (0.48s)',
          image: './ruby.png',
          timeFor: 480000000,
          class: 'ruby33',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.3 YJIT (0.48s)',
          image: './ruby.png',
          timeFor: 480000000,
          class: 'ruby33yjit',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.2 (0.48s)',
          image: './ruby.png',
          timeFor: 480000000,
          class: 'ruby32',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.2 YJIT (0.48s)',
          image: './ruby.png',
          timeFor: 480000000,
          class: 'ruby32yjit',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Artichoke Ruby (19.04s)',
          image: './artichoke.png',
          timeFor: 19040000000,
          class: 'artichokeruby',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Truffle 24.1 (0.49s)',
          image: './truffleruby.png',
          timeFor: 490000000,
          class: 'truffleruby241',
          color: 'rgb(177, 36, 234)'
        },
        {
          label: 'JRuby 9.4.9 (0.78s)',
          image: './jruby.png',
          timeFor: 780000000,
          class: 'jruby949',
          color: 'rgb(39, 185, 247)',
        },
        {
          label: 'MRuby (0.86s)', 
          image: './mruby.png',
          timeFor: 860000000,
          class: 'mruby',
          color: '#e3a1b6'
        },
        {
          label: 'NatalieRuby (12.17s)',
          image: './natalieruby.png',
          timeFor: 12170000000,
          class: 'natalieruby',
          color: 'rgb(215, 48, 22)'
        }
      ],
      1, 7);
  
  const fibonacci = new LatencyVisual('fibonacci', 
      [
        {
          label: 'Truffle 24.1 (1.18s)',
          image: './truffleruby.png',
          timeFor: 1180000000,
          class: 'truffleruby241',
          color: 'rgb(177, 36, 234)'
        },
        {
          label: 'Ruby 3.4 YJIT (2.45s)',
          image: './ruby.png',
          timeFor: 2450000000,
          class: 'ruby34yjit',
          color: 'rgb(50, 20, 10)'
        },
        {
          label: 'Ruby 3.4 (16.70s)', 
          image: './ruby.png',
          timeFor: 16700000000,
          class: 'ruby34',
          color: 'rgb(101, 155, 211)'
        },
        {
          label: 'Ruby 3.3 (16.57s)',
          image: './ruby.png',
          timeFor: 16570000000,
          class: 'ruby33',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.3 YJIT (2.34s)',
          image: './ruby.png',
          timeFor: 2340000000,
          class: 'ruby33yjit',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.2 (15.23s)',
          image: './ruby.png',
          timeFor: 15230000000,
          class: 'ruby32',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Ruby 3.2 YJIT (3.16s)',
          image: './ruby.png',
          timeFor: 3160000000,
          class: 'ruby32yjit',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'Artichoke Ruby (19.04s)',
          image: './artichoke.png',
          timeFor: 19040000000,
          class: 'artichokeruby',
          color: 'rgb(242, 164, 67)'
        },
        {
          label: 'JRuby 9.4.9 (7.67s)',
          image: './jruby.png',
          timeFor: 7670000000,
          class: 'jruby949',
          color: 'rgb(39, 185, 247)',
        },
        {
          label: 'MRuby (29.04s)', 
          image: './mruby.png',
          timeFor: 29040000000,
          class: 'mruby',
          color: '#e3a1b6'
        },
        {
          label: 'NatalieRuby (12.17s)',
          image: './natalieruby.png',
          timeFor: 12170000000,
          class: 'natalieruby',
          color: 'rgb(215, 48, 22)'
        }
      ],
      1, 7);